//
//  MyReviewsPlaceViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/14/25.
//

import SwiftUI
import Combine

/// 내 장소 리뷰 조회 ViewModel
class MyPlaceReviewsViewModel: ObservableObject{
    
    /// 전체 장소 리뷰 목록
    @Published var myPlaceReviews: [PlaceReviewData] = []
    
    /// API 로딩 상태
    @Published var isMyPlaceReviewsLoading: Bool = false
    
    /// 리뷰 개수
    @Published var reviewCount: Int = 0
    
    /// 삭제할 리뷰 ID
    @Published var selectedReviewIdForDeletion: Int? = nil
    
    /// 리뷰 삭제 API 로딩 상태
    @Published var isDeletingReview: Bool = false
    
    /// 마지막 페이지인지 여부
    private var isLast: Bool = false
    
    /// 현재까지 불러온 마지막 리뷰의 방문일
    private var lastPlaceReviewDate: String? = nil
    
    /// 현재까지 불러온 마지막 리뷰의 ID
    private var lastReviewId: Int? = nil
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

// MARK: - Functions
extension MyPlaceReviewsViewModel {
    
    /// 내 장소 리뷰 조회 API 함수
    func getMyPlaceReviews() {
        guard !isMyPlaceReviewsLoading, !isLast else { return }
        
        if isMyPlaceReviewsLoading {
            isMyPlaceReviewsLoading = true
        }
        
        let request = MyPlaceReviewRequest(
            pageSize: 10,
            lastPlaceReviewDate: lastPlaceReviewDate,
            lastReviewId: lastReviewId
        )
        
        container.useCaseProvider.myPageUseCase
            .executeGetMyPlaceReviews(review: request)
            .tryMap { responseData -> ResponseData<MyPlaceReviewResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message,
                                               code: responseData.code)
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isMyPlaceReviewsLoading = false
                switch completion {
                case .finished:
                    print("✅ Get My Place Reviews Completed")
                case .failure(let failure):
                    print("❌ Get My Place Reviews Failed: \(failure)")
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let result = response.result {
                    if result.content.isEmpty {
                        self.myPlaceReviews = []
                    } else {
                        myPlaceReviews.append(contentsOf: result.content)
                    }
                    
                    self.reviewCount = result.reviewCount
                    
                    self.isLast = result.last
                    
                    if !self.isLast, let lastItem = self.myPlaceReviews.last {
                        self.lastPlaceReviewDate = lastItem.visitedDate
                        self.lastReviewId = lastItem.reviewId
                    }
                    
                    print("🎯 Parsed Place Reviews Data: \(result)")
                }
            })
            .store(in: &cancellables)
    }
    
    /// 리뷰 삭제 API
    func deleteReview(reviewId: Int, completion: @escaping () -> Void) {
        guard !isDeletingReview else { return }
        
        isDeletingReview = true
        
        container.useCaseProvider.myPageUseCase.executeDeleteReview(reviewId: reviewId, reviewType: .place)
            .tryMap { responseData -> ResponseData<DeleteReviewResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(
                        message: responseData.message,
                        code: responseData.code
                    )
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isDeletingReview = false
                
                switch completion {
                case .finished:
                    print("✅ Delete Review Completed")
                case .failure(let error):
                    print("❌ Delete Review Failed: \(error)")
                }
            }, receiveValue: { [weak self] _ in
                guard let self = self else { return }
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.myPlaceReviews.removeAll { $0.reviewId == reviewId }
                }
                
                self.reviewCount -= 1
                completion()
            })
            .store(in: &cancellables)
    }
}
