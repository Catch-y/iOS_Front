//
//  ReviewsViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import Foundation
import Combine

class PlaceReviewViewModel: ObservableObject {
    
    @Published var placeReviewData: [ReviewContents] = []
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    var averageRating: Double = 0.0
    var ratingList: [ScoreCount] = []
    var totalCount: Int = 0
    
    var lastPage: Bool = false
    var lastPlaceReviewId: Int? = nil
    var lastPlaceReviewDate: String? = nil
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension PlaceReviewViewModel {
    func getPlaceReviewData(placeId: Int) {
        guard !isLoading, !lastPage else { return }
        
        if placeReviewData.isEmpty {
            isLoading = true
        }
        
        container.useCaseProvider.reviewUseCase.executePlaceReviewResponse(placeId: placeId, request: .init(pageSize: 10, lastPlaceReviewDate: lastPlaceReviewDate, lastPlaceReviewId: lastPlaceReviewId))
            .tryMap { responseData -> ResponseData<PlaceReviewInfoResponse> in
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
                    print("✅ Get Place Review Completed")
                case .failure(let failure):
                    print("❌ Get Place Review Failed: \(failure)")
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let result = response.result {
                    
                    // 평점 및 리뷰 카운트 정보
                    self.averageRating = result.averageRating
                    self.ratingList = result.ratingList
                    self.totalCount = result.totalCount
                    
                    if result.content.isEmpty {
                        self.placeReviewData = []
                    } else {
                        self.placeReviewData.append(contentsOf: result.content)
                    }
                    
                    self.lastPage = result.last
                    
                    if !result.last, let lastItem = result.content.last {
                        self.lastPlaceReviewId = lastItem.reviewId
                        self.lastPlaceReviewDate = lastItem.visitedDate
                    }
                    
                    print("🎯 Parsed Place Review Data: \(result)")
                }
            })
            .store(in: &cancellables)
        
    }
}
