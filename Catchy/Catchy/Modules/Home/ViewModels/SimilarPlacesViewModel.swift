//
//  SimilarPlacesViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import Foundation
import Combine

class SimilarPlacesViewModel: ObservableObject {
    @Published var recommendPlaceResponse: [RecommendPlaceResponseData]?
    
    var currentPage: Int = 1
    var isLastPage: Bool = false
    
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    /// 추가로 보기 클릭 시 데이터 조회
    func getMoreRecommendPlaceRespponse() {
        guard !isLastPage else { return }
        
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
                    
                    print("Get Home More Third Section: \(responseData)")
                    return responseData
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("✅ get home more third section completed")
                    case .failure(let failure):
                        print("❌ get home more third section failure: \(failure)")
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    if let result = response.result {
                        if result.content.isEmpty {
                            recommendPlaceResponse = nil
                        } else {
                            if recommendPlaceResponse == nil {
                                recommendPlaceResponse = result.content
                            } else {
                                recommendPlaceResponse?.append(contentsOf: result.content)
                            }
                            isLastPage = result.isLast
                            if !isLastPage {
                                currentPage += 1
                            }
                        }
                    }
                    print("🔍 More Third Section updated: \(String(describing: response.result))")
                })
                .store(in: &cancellables)
        }
    }
    
    func getHomeSearch() async {
        self.isLastPage = false
        self.currentPage += 1
        
        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)
            self.recommendPlaceResponse = nil
            getMoreRecommendPlaceRespponse()
        } catch {
            print("❌ Refresh 오류: \(error)")
        }
    }
}
