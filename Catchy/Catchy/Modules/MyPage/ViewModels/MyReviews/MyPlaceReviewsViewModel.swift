//
//  MyReviewsPlaceViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/14/25.
//

import SwiftUI
import Combine

/// ViewModel for MyPlaceReviewsView
class MyPlaceReviewsViewModel: ObservableObject {
    
    /// 내 장소 리뷰 조회 Response
    @Published var myPlaceReviewsData: MyPlaceReviewResponse?
    
    /// API 로딩 상태
    @Published var isLoading: Bool = false
    
    /// 리뷰 개수
    @Published var reviewCount: Int = 0
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyPlaceReviewsViewModel {
    func getMyPlaceReviews(review: MyPlaceReviewRequest) {
        isLoading = true

        container.useCaseProvider.myPageUseCase.executeGetMyPlaceReviews(review: review)
            .tryMap { responseData -> ResponseData<MyPlaceReviewResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    print("✅ Get My Place Reviews Completed")
                case .failure(let error):
                    print("❌ Get My Place Reviews Failed: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let result = response.result {
                    self.myPlaceReviewsData = result
                    self.reviewCount = result.reviewCount
                }
            })
            .store(in: &cancellables)
    }
}
