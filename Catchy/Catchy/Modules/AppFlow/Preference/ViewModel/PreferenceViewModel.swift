//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import CoreGraphics
import MapKit
import Combine
import Moya

class PreferenceViewModel: ObservableObject {
    
    let container: DIContainer
    let appFlowViewModel: AppFlowViewModel
    
    private var cancellalbes = Set<AnyCancellable>()
    
    init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
        self.container = container
        self.appFlowViewModel = appFlowViewModel
    }
    
    @Published var isLoading: Bool = false
    
    //MARK: - 전체 스텝 관리
    @Published var preferenceStep: Int = 0
    
    //MARK: - 1번째, 2번째 스텝 관리
    @Published var pageCount: Int = 0
    
    /* Request 저장 */
    @Published var bigCategoryBtn: [CategoryType] = []
    @Published var smallCategoryBtn: [CategoryType: [String]] = [:]
    
    func getSmallCategory(category: CategoryType) -> [String] {
        return category.subcategories
    }
    
    //MARK: - 3번째, 4번째 스텝 관리
    @Published var selectedCompanion: [CompanionType] = []
    
    @Published var selectedWeekDay: [ActiveDate] = []
    @Published var leftSelectedTime: Date? = nil
    @Published var rightSelectedTime: Date? = nil
    
    @Published var isExpand: [Int:Bool] = [0: false, 1: false]
    
    //MARK: - 5번째 지도 관리
    @Published var polygons: [PolygonData] = []
    @Published var isDistrictsSheet: Bool = false
    @Published var regionDistricts: [String: [String]] = [:]
    @Published var selectedRegion: String? = nil
    @Published var selectedRegionCode: String? = nil
    @Published var savedDistricts: [StepFourStep] = []
    
    
    let referenceLogitude: Double = 127.5
    let referenceLatitude: Double = 36.5
    let scaleFactor: CGFloat = 0.05
}

extension PreferenceViewModel {
    /// 시/도 데아터 조회 함수
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
    
    /// 위도 경도 값 x y 좌표 값 전환
    /// - Parameters:
    ///   - latitude: 위도 값
    ///   - longitude: 경도 값
    /// - Returns: CGPoint로 반환
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

//MARK: - PreferenceAPI Extension

extension PreferenceViewModel {
    
    /// 취향 1,2 단계 데이터 전송
    func postSurveyCategory() {
        
        isLoading = true
        
        let selectedCategories = smallCategoryBtn.values.flatMap { $0 }
        
        container.useCaseProvider.memberUseCase.executePostServeyCategory(categories: selectedCategories)
            .tryMap { responseData -> ResponseData<StepOneResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                
                print("✅ 취향 1,2 단계 데이터 전송: \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    print("✅ 모든 취향 데이터 전송 완료")
                    postSurveyStyleTime()
                case .failure(let error):
                    print("❌ 모든 취향 데이터 전송 API 호출 실패: \(error)")
                }
            }, receiveValue: { response in
                if let response = response.result {
                    print("취향 1단계 및 2단계 response: \(response)")
                }
            })
            .store(in: &cancellalbes)
    }
    
    /// 취향 3, 4 단계 데이터 전송
    func postSurveyStyleTime() {
        
        guard let leftTime = leftSelectedTime,
              let rightTime = rightSelectedTime else {
            print("❌ 시작 시간 또는 종료 시간이 설정되지 않음")
            return
        }
        
        let activeTimes = selectedWeekDay.map { day in
            ActiveDateDTO(dayOfWeek: day, startTime: DataFormatter.shared.timeString(from: leftTime), endTime: DataFormatter.shared.timeString(from: rightTime))
        }
        
        print("뷰모델전송: \(activeTimes)")
        
        container.useCaseProvider.memberUseCase.executePostServeyStyleTime(styleTime: .init(styleNames: selectedCompanion, activeTimes: activeTimes))
            .tryMap { responseData -> ResponseData<StepTwoResponse> in
                
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                
                print("✅ 취향 3 4단계 데이터 전송: \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ 모든 시간, 같이할 사람 전송 완료")
                case .failure(let error):
                    print("❌ 모든 시간, 같이할 사람 전송 실패: \(error)")
                }
            }, receiveValue: { response in
                if let response = response.result {
                    print("취향 3단계 및 4단계 response: \(response)")
                    self.postLocation()
                }
            })
            .store(in: &cancellalbes)
    }
    
    /// 취향 5단계 데이터 전송
    func postLocation() {
        guard !savedDistricts.isEmpty else {
            print("선택된 지역이 없습니다.")
            return
        }
        
        let location = savedDistricts.map { location in
            StepFourStep(upperLocation: location.upperLocation, lowerLocation: location.lowerLocation)
        }
        
        print("선택 지역 출력: \(location)")
        
        container.useCaseProvider.memberUseCase.executePostLocation(locations: location)
            .tryMap { responseData -> ResponseData<StepThirdResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                
                print("✅ 취향 5단계 데이터 전송: \(responseData)")
                return responseData
                
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                
                guard let self = self else { return }
                isLoading = false
                
                switch completion {
                case .finished:
                    print("✅ 지역 전송 완료")
                    appFlowViewModel.changeTabView()
                case .failure(let failure):
                    print("❌ 지역 전송 실패 \(failure)")
                }
            }, receiveValue: { response in
                if let response = response.result {
                    print("취향 5단계 response: \(response)")
                }
            })
            .store(in: &cancellalbes)
    }
}
