//
//  PlaceVisitingViewModel.swift
//  Catchy
//
//  Created by LEE on 2/10/25.
//

import Foundation
import SwiftUI
import Combine
import CombineMoya

class PlaceVisitingViewModel: ObservableObject {

    let container: DIContainer

    var cancellables = Set<AnyCancellable>()

    // MARK: - 장소 방문 체크 화면 Properties
    /// 현재 화면에서 보여주는 장소 데이터
    @Published var placeDetailResponse: PlaceDetailResponse?

    /// 로딩중인가?
    @Published var isLoading: Bool = false

    // MARK: - 장소 리뷰, 평점 화면 상태
    /// 리뷰, 평점 화면 상태
    @Published var isReviewPresented: Bool = false
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }

}

extension PlaceVisitingViewModel {

    // MARK: - API 요청 함수
    /// 장소 상세화면 API
    /// - Parameter placeId: 상세화면에서 보여줄 장소 ID
    func getPlaceDetail(placeId: Int) {
        
        isLoading = true
        
        container.useCaseProvider.placeCourseUseCase.executeGetPlaceDetail(placeId: placeId)
            .tryMap {
                responseData ->
                ResponseData<PlaceDetailResponse> in
                if !responseData.isSuccess {
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }

                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Get PlaceDetail Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceDetail Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let response = response.result {
                    self.placeDetailResponse = response
                }
            })
            .store(in: &cancellables)
    }
    
    /// 장소 좋아요 API
    func patchPlaceLike() {
        
        guard let placeId = placeDetailResponse?.placeId else { return }

        container.useCaseProvider.placeUseCase.executePatchPlaceLiked(placeId: placeId)
            .tryMap {responseData ->
                ResponseData<PlaceLikedResponse> in
                if !responseData.isSuccess {
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                completion in
                switch completion {
                case .finished:
                    print("✅ Patch PlaceLiked Server Completed")
                case .failure(let failure):
                    print("❌ Patch PlaceLiked Failed: \(failure)")
                }
            },receiveValue: { response in

            })
            .store(in: &cancellables)
    }
    
    /// 장소 방문 체크 API
    func postPlaceVisiting() {
        
        guard let placeId = placeDetailResponse?.placeId else { return }

        container.useCaseProvider.courseUseCase.executePostPlaceVisit(placeId: placeId)
            .tryMap {responseData ->
                ResponseData<PlaceVisitResponse> in
                if !responseData.isSuccess {
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                completion in

                switch completion {
                case .finished:
                    print("✅ Post PlaceVisit Server Completed")
                case .failure(let failure):
                    print("❌ Ppost PlaceVisit Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let response = response.result {
                    self.placeDetailResponse?.isVisited = response.isVisited
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: - API 호출 없는 함수
    /// 장소 평점, 리뷰 화면  보여줍니다
    /// - Parameter placeId: 리뷰, 평점을 볼 장소 ID
    func showReview() {
        self.isReviewPresented.toggle()
    }
    
    
    func showReviewRegister() {
        
    }
    
}
