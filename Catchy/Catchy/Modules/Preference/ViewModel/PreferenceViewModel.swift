//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import CoreGraphics
import MapKit

class PreferenceViewModel: ObservableObject {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    //MARK: - 전체 스텝 관리
    @Published var preferenceStep: Int = 0
    
    //MARK: - 1번째, 2번째 스텝 관리
    @Published var pageCount: Int = 0
    
    /* Request 저장 */
    @Published var bigCategoryBtn: [CategoryType] = [.BAR, .CAFE]
    @Published var smallCategoryBtn: [CategoryType: [String]] = [:]
    
    func getSmallCategory(category: CategoryType) -> [String] {
        return category.subcategories
    }
    
    //MARK: - 3번째, 4번째 스텝 관리
    /// RequestData
    @Published var stepThirdData: StepThirdRequest?
    
    @Published var selectedCompanion: [CompanionType] = []
    @Published var selectedWeekDay: [ActiveDate] = []
    @Published var startTime: String = ""
    @Published var endTime: String = ""
    
    @Published var leftSelectedTime: Date? = nil
    @Published var rightSelectedTime: Date? = nil
    
    @Published var isExpand: [Int:Bool] = [0: false, 1: false]
    
    //MARK: - 5번째 지도 관리
    @Published var polygons: [PolygonData] = []
    @Published var isDistrictsSheet: Bool = false
    @Published var savedDistricts: [String] = []
    
    let referenceLogitude: Double = 127.5
    let referenceLatitude: Double = 36.5
    let scaleFactor: CGFloat = 0.05
}

extension PreferenceViewModel {
    public func loadGeoJSON() {
            guard let filePath = Bundle.main.path(forResource: "Sido", ofType: "geojson") else { return }
            
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let features = json["features"] as? [[String: Any]] {

                    var uniquePolygons = Set<String>() // 중복 방지를 위한 Set
                    var allPoints: [CGPoint] = [] // 중심점 계산을 위한 모든 좌표 저장
                    
                    polygons.removeAll() // 기존 데이터 초기화

                    for feature in features {
                        if let geometry = feature["geometry"] as? [String: Any],
                           let type = geometry["type"] as? String,
                           type == "Polygon",
                           let coordinatesArray = geometry["coordinates"] as? [[[Double]]],
                           let properties = feature["properties"] as? [String: Any],
                           let regionName = properties["SIG_KOR_NM"] as? String,
                           let regionCode = properties["CTPRVN_CD"] as? String {

                            for coordinates in coordinatesArray {
                                let cgPoints = coordinates.map { convertToCGPoint(latitude: $0[1], longitude: $0[0]) }
                                
                                allPoints.append(contentsOf: cgPoints) // 중심점 계산을 위한 좌표 추가

                                // 중복 검사: 좌표 배열을 문자열로 변환하여 비교
                                let pointsKey = cgPoints.map { "\($0.x),\($0.y)" }.joined(separator: "|")
                                if uniquePolygons.insert(pointsKey).inserted {
                                    let center = calculateCentroid(points: cgPoints)
                                    polygons.append(PolygonData(
                                        id: UUID(), // 고유 ID 추가
                                        points: cgPoints,
                                        offset: .zero,
                                        scale: 1.0,
                                        regionName: regionName,
                                        regionCode: regionCode,
                                        center: center
                                    ))
                                }
                            }
                        }
                    }

                    // 중심점과 스케일 조정
                    if let offset = calculateCenterOffset(from: allPoints) {
                        let scale = calculateScale(from: allPoints) * 1.0
                        polygons = polygons.map { polygon in
                            PolygonData(
                                id: polygon.id,
                                points: polygon.points,
                                offset: offset,
                                scale: scale,
                                regionName: polygon.regionName,
                                regionCode: polygon.regionCode,
                                center: polygon.center
                            )
                        }
                    }
                }
            } catch {
                print("GeoJSON 파일 로딩 오류: \(error)")
            }
        }
    
    private func convertToCGPoint(latitude: Double, longitude: Double) -> CGPoint {
        let x = longitude
        let y = -latitude
        return CGPoint(x: x, y: y)
    }
    
    
    private func calculateCentroid(points: [CGPoint]) -> CGPoint {
           var area: CGFloat = 0.0
           var centroidX: CGFloat = 0.0
           var centroidY: CGFloat = 0.0

           for i in 0..<points.count {
               let j = (i + 1) % points.count
               let temp = points[i].x * points[j].y - points[j].x * points[i].y
               area += temp
               centroidX += (points[i].x + points[j].x) * temp
               centroidY += (points[i].y + points[j].y) * temp
           }

           area *= 0.5
           centroidX /= (6.0 * area)
           centroidY /= (6.0 * area)

           return CGPoint(x: centroidX, y: centroidY)
       }
    
    private func calculateCenterOffset(from points: [CGPoint]) -> CGPoint? {
        guard !points.isEmpty else { return nil }
        let minX = points.map { $0.x }.min() ?? 0
        let maxX = points.map { $0.x }.max() ?? 0
        let minY = points.map { $0.y }.min() ?? 0
        let maxY = points.map { $0.y }.max() ?? 0
        return CGPoint(x: (minX + maxX) / 2, y: (minY + maxY) / 2)
    }
    
    private func calculateScale(from points: [CGPoint]) -> CGFloat {
        guard !points.isEmpty else { return 1.0 }
        let minX = points.map { $0.x }.min() ?? 0
        let maxX = points.map { $0.x }.max() ?? 0
        let minY = points.map { $0.y }.min() ?? 0
        let maxY = points.map { $0.y }.max() ?? 0
        
        let widthScale = 650 / (maxX - minX)
        let heightScale = 900 / (maxY - minY)
        
        return min(widthScale, heightScale)
    }
    
    func convertToLatLon(from point: CGPoint, in rect: CGRect) -> (latitude: Double, longitude: Double) {
        let centerX = rect.midX
        let centerY = rect.midY
        
        let longitude = (point.x - centerX) / scaleFactor + referenceLogitude
        let latitude = referenceLatitude - (point.y - centerY) / scaleFactor
        
        return (latitude, longitude)
    }
    
    func getRegionInfo(at location: CGPoint, in rect: CGRect) -> (name: String, code: String)? {
            for polygon in polygons {
                let transformedPoints = polygon.points.map {
                    CGPoint(
                        x: ($0.x - polygon.offset.x) * polygon.scale + rect.midX,
                        y: ($0.y - polygon.offset.y) * polygon.scale + rect.midY
                    )
                }
                let path = CGMutablePath()
                path.addLines(between: transformedPoints)
                path.closeSubpath()

                if path.contains(location) {
                    return (polygon.regionName, polygon.regionCode)
                }
            }
            return nil
        }
    
    
}
