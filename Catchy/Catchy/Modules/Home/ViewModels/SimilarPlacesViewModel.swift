//
//  SimilarPlacesViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import Foundation
import Combine

@MainActor
class SimilarPlacesViewModel: ObservableObject {
    
    @Published var recommendPlaceResponse: [RecommendPlaceResponseData]?
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false

    var currentPage: Int = 1
    var isLastPage: Bool = false
    
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    /// 추가로 보기 클릭 시 데이터 조회
    func getMoreRecommendPlaceRespponse(isRefresh: Bool = false) {
        guard !isLoading, !isLastPage else { return }
        
        if !isRefresh  {
            self.isLoading = true
        }

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
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    
                    self.isLoading = false

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
    
    /// 추가로 보기 클릭 시 데이터 리프레시
    func getRecommendPlaceRefresh() async {
        self.isLastPage = false
        self.currentPage = 1
        self.isRefreshing = true
        
        await withCheckedContinuation { continuation in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    continuation.resume()
                }
            }
        
        recommendPlaceResponse = nil

        await withCheckedContinuation { continuation in
            let cancellable = container.useCaseProvider.homeUseCase
                .executeGetRecommendPlaces(userLocation: .init(latitude: 37.566612, longitude: 126.978244), page: currentPage)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("✅ Refresh 완료")
                    case .failure(let error):
                        print("❌ Refresh 실패: \(error)")
                    }
                    continuation.resume()
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    if let result = response.result {
                        self.recommendPlaceResponse = result.content
                        self.isLastPage = result.isLast
                        if !self.isLastPage {
                            self.currentPage += 1
                        }
                    }
                })

            self.cancellables.insert(cancellable)
        }
    }
    
    /// 홈 장소 디에틸 뷰 좋아요
    /// - Parameter placeId: 장소 id 입력
    func patchLikePlace(placeId: Int) {
        
        print("좋아요 장소 ID: \(placeId)")
        
        container.useCaseProvider.placeUseCase.executePatchPlaceLiked(placeId: placeId)
            .tryMap { responseData -> ResponseData<PlaceLikedResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                
                guard let _ = responseData.result else {
                    throw APIError.emptyResult
                }
                
                print("Patch Like Place: \(responseData)")
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Patch PlaceLiked Server Completed")
                case .failure(let failure):
                    print("❌ Patch PlaceLiked Failed: \(failure)")
                }
                
            }, receiveValue: { response in
                if let response = response.result {
                    print("장소 좋아요 결과: \(response)")
                }
            })
            .store(in: &cancellables)
    }
}
