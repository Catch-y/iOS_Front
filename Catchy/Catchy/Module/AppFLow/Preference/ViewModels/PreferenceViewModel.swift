//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import Foundation
import CoreGraphics

@Observable
class PreferenceViewModel {
    // MARK: - StateProperty
    var isExpand: [Int: Bool] = [0: false, 1: false]
    var isLoading: Bool = false
    var isShowSheet: Bool = false
    
    // MARK: - Property
    let nickname: String = UserDefaults.standard.string(forKey: AppStorageKey.userNickname) ?? "정보 없음"
    var preferencPage: PageType
    
    // MARK: - First
    var bigCategoryBtn: [CategoryType] = [.BAR, .EXPERIENCE, .RESTAURANT]
    
    // MARK: - Second
    var smallCategoryBtn: [CategoryType: [String]] = [:]
    var categoryPage: Int = 0
    
    // MARK: - Third
    var selectedCompanion: [CompanionType] = .init()
    var selectedWeekDay: [ActiveDate] = .init()
    var leftSelectedTime: Date?
    var rightSelectedTime: Date?
    
    // MARK: - Fourth
    var polygons: [PolygonData] = .init()
    var tappedLocatoin: UserLocation? = nil
    var selectedRegion: String? = nil
    var selectedRegionCode: String? = nil
    var regionDistricts: [String: [String]] = .init()
    var postDistrictsInfo: [MemberLocationRequest] = .init()
    var viewScaleFactor: CGFloat = 1.0
    let scaleFactor: CGFloat = 0.05
    let referenceLogitude: Double = 127.5
    let referenceLatitude: Double = 36.5
    
    // MARK: - Dependency
    let container: DIContainer
    let appFlow: AppFlow
    
    // MARK: - Init
    init(container: DIContainer, appFlow: AppFlow) {
        self.container = container
        self.appFlow = appFlow
        self.preferencPage = .one(nickname: nickname)
    }
    
    // MARK: - Method
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
    
    /// 위도 경도 값 x y 좌표 값 전환
    /// - Parameters:
    ///   - latitude: 위도 값
    ///   - longitude: 경도 값
    /// - Returns: CGPoint로 반환
    func convertToCGPoint(latitude: Double, longitude: Double) -> CGPoint {
        let x = longitude
        let y = -latitude
        return CGPoint(x: x, y: y)
    }
    
    func convertToLatLon(from point: CGPoint, in rect: CGRect) -> (latitude: Double, longitude: Double) {
        let centerX = rect.midX
        let centerY = rect.midY
        
        let longitude = (point.x - centerX) / scaleFactor + referenceLogitude
        let latitude = referenceLatitude - (point.y - centerY) / scaleFactor
        
        return (latitude, longitude)
    }
    
    func calculateCentroid(points: [CGPoint]) -> CGPoint {
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
    
    func getRegionInfo(at locatoin: CGPoint, in rect: CGRect) -> (name: String, code: String)? {
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
            
            if path.contains(locatoin) {
                return (polygon.regionName, polygon.regionCode)
            }
        }
        
        return nil
    }
    
    public func loadGeoJSON() {
        guard let filePath = Bundle.main.path(forResource: "Sido", ofType: "geojson") else { return }
        
        do {
            let fileURL = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileURL)
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let features = json["features"] as? [[String: Any]] {
                
                var uniquePolygons = Set<String>()
                var allPoints: [CGPoint] = []
                
                polygons.removeAll()
                
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
}
