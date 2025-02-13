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

    @Published var placeDetailResponse: PlaceDetailResponse?

    init(container: DIContainer) {
        self.container = container
    }

}

extension PlaceVisitingViewModel {

    /// 장소 상세화면 API
    func getPlaceDetail(placeId: Int) {

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
                [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .finished:
                    print("✅ Patch PlaceLiked Server Completed")
                case .failure(let failure):
                    print("❌ Patch PlaceLiked Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let response = response.result {
                    self.placeDetailResponse?.liked = response.liked
                }
            })
            .store(in: &cancellables)
    }
}
