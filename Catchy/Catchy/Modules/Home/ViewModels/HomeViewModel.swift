//
//  HomeViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var courseInfoResponse: [CourseInfoResponse]? /* 찻 번째 섹션 */
    @Published var popularCourseResponse: [PopularCourseResponse]? /* 두 번째 섹션 */
    @Published var recommendPlaceResponse: [RecommendPlaceResponseData] = [] /* 세 번째 섹션 */
    
    @Published var isHomeLoading: [Bool] = [true, true, false]
    
    var isLastPage: Bool = false
    var currentPage = 1
    
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension HomeViewModel {
    /// 홈의 첫 번째 ai 추천 섹션
    func getFirstSection() {
        
        isHomeLoading[0] = true
        
        container.useCaseProvider.homeUseCase.executeHomePersonalCourses()
            .tryMap { responseData -> ResponseData<[CourseInfoResponse]> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                
                print("Get Home First Section: \(responseData)")
                return responseData
        }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                isHomeLoading[0] = false
                
                switch completion {
                case .finished:
                    print("✅ get home firstSection completed")
                case .failure(let failure):
                    print("❌ get home firstSection failure: \(failure)")
                    courseInfoResponse = nil
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let response = response.result {
                    if response.isEmpty {
                        courseInfoResponse = nil
                    } else {
                        courseInfoResponse = response
                    }
                }
                print("🔍 get home firstSection updated: \(String(describing: response.result))")
            })
            .store(in: &cancellables)
    }
    
    /// 홈의 두 번째 Topten 섹션
    func getSecondSection() {
        
        isHomeLoading[1] = true
        
        container.useCaseProvider.homeUseCase.executeGetHomeCourseTopTen()
            .tryMap { responseData -> ResponseData<[PopularCourseResponse]> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                
                print("Get Home Second Section: \(responseData)")
                return responseData
        }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                isHomeLoading[1] = false
                
                switch completion {
                case .finished:
                    print("✅ get home firstSection completed")
                case .failure(let failure):
                    print("❌ get home firstSection failure: \(failure)")
                    courseInfoResponse = nil
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let response = response.result {
                    if response.isEmpty {
                        popularCourseResponse = nil
                    } else {
                        popularCourseResponse = response
                    }
                }
                print("🔍 get home secondSection updated: \(String(describing: response.result))")
            })
            .store(in: &cancellables)
    }
    
    /// 홈의 세 번째 취향 데이터 섹션
    func getThirdSection() {
        
        guard !isLastPage,  !isHomeLoading[2] else { return }
        
        isHomeLoading[2] = true
        
        BaseLocationManager.shared.getCurrentUserLocation { [weak self] location in
            
            guard let self = self else { return }
            
            print("현재 위치: \(String(describing: location))")
            
            let lat = location?.coordinate.latitude ?? 37.566612
            let long = location?.coordinate.longitude ?? 126.978244
            
            let formattedLatitude = Double(String(format: "%.8f", lat)) ?? lat
            let formattedLongitude = Double(String(format: "%.8f", long)) ?? long
            
            container.useCaseProvider.homeUseCase.executeGetRecommendPlaces(userLocation: .init(latitude: formattedLatitude, longitude: formattedLongitude), page: currentPage)
                .tryMap { responseData -> ResponseData<RecommendPlaceResponse> in
                    if !responseData.isSuccess {
                        throw APIError.serverError(message: responseData.message, code: responseData.code)
                    }
                    
                    guard let _ = responseData.result else {
                        throw APIError.emptyResult
                    }
                    
                    print("Get Home Third Section: \(responseData)")
                    return responseData
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    
                    isHomeLoading[2] = false
                    
                    switch completion {
                    case .finished:
                        print("✅ get home third section completed")
                    case .failure(let failure):
                        print("❌ get home third section failure: \(failure)")
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    
                    if let response = response.result {
                        recommendPlaceResponse.append(contentsOf: response.content)
                        
                        print("3번 째: \(response)")
                        
                        isLastPage = response.isLast
                        if !isLastPage {
                            currentPage += 1
                        }
                    }
                })
                .store(in: &cancellables)
        }
    }
}
