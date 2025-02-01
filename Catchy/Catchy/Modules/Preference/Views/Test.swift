import SwiftUI
import CoreGraphics
import MapKit

struct PolygonCanvasView: View {
    @StateObject private var viewModel = PreferenceViewModel(container: DIContainer())
    
    @State private var scaleFactor: CGFloat = 1.0
    @State private var selectedRegion: String? = nil
    @State private var selectedRegionCode: String? = nil
    @State private var tappedLocation: (latitude: Double, longitude: Double)? = nil
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    
                    // ✅ 폴리곤 그리기
                    ForEach(viewModel.polygons, id: \.points) { polygon in
                        PolygonShape(points: polygon.points, scale: polygon.scale * scaleFactor, offset: polygon.offset)
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    
                    // ✅ 폴리곤 중앙에 지역명(SIG_KOR_NM) 표시
                    ForEach(viewModel.polygons, id: \.regionName) { polygon in
                        let transformedCenter = CGPoint(
                            x: (polygon.center.x - polygon.offset.x) * polygon.scale * scaleFactor + geometry.size.width / 2,
                            y: (polygon.center.y - polygon.offset.y) * polygon.scale * scaleFactor + geometry.size.height / 2
                        )
                        
                        Text(polygon.regionName)
                            .font(.caption_SM)
                            .foregroundStyle(Color.g7)
                            .offset(y: adjustTextOffset(for: polygon.regionName))
                            .position(x: transformedCenter.x, y: transformedCenter.y)
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            let location = value.location
                            
                            let latLon = viewModel.convertToLatLon(from: location, in: geometry.frame(in: .local))
                            tappedLocation = latLon
                            
                            if let regionInfo = viewModel.getRegionInfo(at: location, in: geometry.frame(in: .local)) {
                                selectedRegion = regionInfo.name
                                selectedRegionCode = regionInfo.code
                                print("✅ 선택한 지역: \(regionInfo.name), 코드: \(regionInfo.code)")
                            }
                        }
                )
            }
        }
        .task {
            viewModel.loadGeoJSON()
        }
    }
    
       private func adjustTextOffset(for regionName: String) -> CGFloat {
           switch regionName {
           case "충청남도":
               return 10
           case "경기도":
               return 15
           case "인천광역시":
               return 4
           default:
               return 0
           }
       }
}

#Preview {
    PolygonCanvasView()
}
