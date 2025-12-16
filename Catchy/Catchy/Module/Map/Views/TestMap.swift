import SwiftUI
import MapKit
import CoreLocation

// MARK: - 1. Data Models (JSON Parsing)

struct RouteData: Decodable {
    let features: [RouteFeature]
}

struct RouteFeature: Decodable, Identifiable {
    let id = UUID() // SwiftUI 리스트/맵용 ID
    let type: String
    let geometry: RouteGeometry
    let properties: RouteProperties
    
    private enum CodingKeys: String, CodingKey {
        case type, geometry, properties
    }
}

// Geometry가 Point일 수도 있고 LineString일 수도 있어서 Enum으로 처리
enum RouteGeometry: Decodable {
    case point(CLLocationCoordinate2D)
    case lineString([CLLocationCoordinate2D])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        if type == "Point" {
            let coords = try container.decode([Double].self, forKey: .coordinates)
            // GeoJSON은 [Long, Lat] 순서 -> MapKit은 (Lat, Long)
            self = .point(CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0]))
        } else if type == "LineString" {
            let coords = try container.decode([[Double]].self, forKey: .coordinates)
            let coordinates = coords.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
            self = .lineString(coordinates)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown geometry type")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case type, coordinates
    }
}

struct RouteProperties: Decodable {
    let index: Int
    let name: String
    let description: String
    let pointType: String? // "SP": 시작, "EP": 도착, "GP": 일반
    
    // JSON에 없는 필드가 있을 수 있으므로 옵셔널 처리
    var isStopPoint: Bool {
        return pointType != nil
    }
}

// MARK: - 2. ViewModel

class MapRouteViewModel: ObservableObject {
    @Published var pathCoordinates: [CLLocationCoordinate2D] = []
    @Published var waypoints: [RouteFeature] = []
    @Published var centerRegion: MapCameraPosition = .automatic
    
    func loadJSON() {
        // 제공해주신 JSON 데이터 문자열
        let jsonString = """
        {
            "type": "FeatureCollection",
            "features": [
                {
                    "type": "Feature",
                    "geometry": { "type": "Point", "coordinates": [127.0289460733333, 37.50049659644769] },
                    "properties": { "index": 0, "name": "출발", "description": "241m 이동", "pointType": "SP" }
                },
                {
                    "type": "Feature",
                    "geometry": { "type": "LineString", "coordinates": [[127.0289460733333, 37.50049659644769], [127.0289405167124, 37.50055214545025], [127.0289238492847, 37.50063269134938], [127.02887107128325, 37.50081044752926], [127.0288155181919, 37.50090210255074], [127.02875718867531, 37.500954873150775], [127.02866275211979, 37.50097986855147], [127.02858220373889, 37.50098542201571], [127.0284961007794, 37.500974310649546], [127.02787671774098, 37.500796542403414], [127.02773784267133, 37.50075487808375], [127.02723789242053, 37.50060488653306], [127.02676849494419, 37.500454895531036]] },
                    "properties": { "index": 1, "name": "", "description": ", 241m" }
                },
                {
                    "type": "Feature",
                    "geometry": { "type": "Point", "coordinates": [127.02676849494419, 37.500454895531036] },
                    "properties": { "index": 2, "name": "품", "description": "품에서 우회전 후 78m 이동", "pointType": "GP" }
                },
                {
                    "type": "Feature",
                    "geometry": { "type": "LineString", "coordinates": [[127.02676849494419, 37.500454895531036], [127.0267296092021, 37.50046878210859], [127.02643795140972, 37.50109370427346]] },
                    "properties": { "index": 3, "name": "", "description": ", 78m" }
                },
                {
                    "type": "Feature",
                    "geometry": { "type": "Point", "coordinates": [127.02643795140972, 37.50109370427346] },
                    "properties": { "index": 4, "name": "강남약국", "description": "강남약국에서 좌측 횡단보도 후 강남대로를 따라 40m 이동", "pointType": "GP" }
                },
                {
                    "type": "Feature",
                    "geometry": { "type": "LineString", "coordinates": [[127.02643795140972, 37.50109370427346], [127.02619630885941, 37.501018708647955], [127.02601854891178, 37.50096037889985]] },
                    "properties": { "index": 5, "name": "강남대로", "description": "강남대로, 40m" }
                },
                {
                    "type": "Feature",
                    "geometry": { "type": "Point", "coordinates": [127.02601854891178, 37.50096037889985] },
                    "properties": { "index": 6, "name": "CGV 강남", "description": "도착", "pointType": "EP" }
                }
            ]
        }
        """.data(using: .utf8)!
        
        do {
            let decodedData = try JSONDecoder().decode(RouteData.self, from: jsonString)
            
            // 데이터 분리: 1. 선(Polyline) 그리기용 좌표 배열, 2. 마커(Point)용 Feature
            var allLineCoordinates: [CLLocationCoordinate2D] = []
            var points: [RouteFeature] = []
            
            for feature in decodedData.features {
                switch feature.geometry {
                case .lineString(let coords):
                    allLineCoordinates.append(contentsOf: coords)
                case .point:
                    // Point 타입은 마커로 사용
                    if feature.properties.isStopPoint {
                        points.append(feature)
                    }
                }
            }
            
            self.pathCoordinates = allLineCoordinates
            self.waypoints = points
            
            // 카메라 위치 설정 (첫 번째 좌표 기준)
            if let first = allLineCoordinates.first {
                self.centerRegion = .region(MKCoordinateRegion(
                    center: first,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                ))
            }
            
        } catch {
            print("JSON Decoding Error: \(error)")
        }
    }
}

// MARK: - 3. SwiftUI View

struct RouteMapView: View {
    @StateObject private var viewModel = MapRouteViewModel()
    
    var body: some View {
        Map(position: $viewModel.centerRegion) {
            
            // 1. 경로 그리기 (Polyline)
            if !viewModel.pathCoordinates.isEmpty {
                MapPolyline(coordinates: viewModel.pathCoordinates)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
            }
            
            // 2. 주요 지점 마커 찍기 (Point)
            ForEach(viewModel.waypoints) { feature in
                if case .point(let coordinate) = feature.geometry {
                    Annotation(feature.properties.name, coordinate: coordinate) {
                        VStack(spacing: 0) {
                            Image(systemName: getIconName(for: feature.properties.pointType))
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(getColor(for: feature.properties.pointType))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                            
                            Image(systemName: "triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 6)
                                .foregroundColor(getColor(for: feature.properties.pointType))
                                .rotationEffect(.degrees(180))
                                .offset(y: -2)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadJSON()
        }
        .ignoresSafeArea()
    }
    
    // 포인트 타입에 따른 아이콘 설정
    func getIconName(for type: String?) -> String {
        switch type {
        case "SP": return "figure.walk" // 시작점
        case "EP": return "flag.checkered" // 도착점
        default: return "arrow.turn.up.right" // 중간 경유지(회전 등)
        }
    }
    
    // 포인트 타입에 따른 색상 설정
    func getColor(for type: String?) -> Color {
        switch type {
        case "SP": return .green
        case "EP": return .red
        default: return .orange
        }
    }
}

#Preview {
    RouteMapView()
}
