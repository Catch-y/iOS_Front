//
//  MyReviewsCourseViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/14/25.
//

import SwiftUI
import Combine

/// MyCourseReviewsViewModel: 내 코스 리뷰 화면을 위한 ViewModel
class MyCourseReviewsViewModel: ObservableObject, DeleteReviewPopupViewModelProtocol {
    
    /// 전체 코스 리뷰 목록을 담는 배열
    @Published var myCourseReviews: [CourseReviewData] = []
    
    /// 로딩 상태
    @Published var isMyCourseReviewsLoading: Bool = false
    
    /// 리뷰 전체 개수
    @Published var reviewCount: Int = 0
    
    /// 삭제 팝업 창 상태
    @Published var showDeletePopup: Bool = false
    
    /// 삭제할 리뷰 ID
    @Published var selectedReviewIdForDeletion: Int? = nil
    
    /// 리뷰 삭제 API 로딩 상태
    @Published var isDeletingReview: Bool = false
    
    /// 마지막 페이지인지 여부
    private var isLast: Bool = false
    
    /// 현재까지 불러온 리뷰의 마지막 ID
    private var lastReviewId: Int? = nil
    
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyCourseReviewsViewModel {
    /// 내 코스 리뷰 조회 API 호출
    func getMyCourseReviews() {
        
        /* 이미 로딩 중이거나 마지막 페이지라면 중단 */
        guard !isMyCourseReviewsLoading, !isLast else {
            return
        }
        
        if myCourseReviews.isEmpty {
            isMyCourseReviewsLoading = true
        }
        
        let review = MyCourseReviewRequest(pageSize: 10, lastReviewId: lastReviewId)
        
        container.useCaseProvider.myPageUseCase.executeGetMyCourseReviews(review: review)
            .tryMap { responseData -> ResponseData<MyCourseReviewResponse> in
                if !responseData.isSuccess {
                    throw APIError.serverError(message: responseData.message, code: responseData.code)
                }
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isMyCourseReviewsLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Get My Course Reviews Completed")
                case .failure(let failure):
                    print("❌ Get My Course Reviews Failed: \(failure)")
                }
                
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let result = response.result {
                    if result.content.isEmpty {
                        self.myCourseReviews = []
                    } else {
                        myCourseReviews.append(contentsOf: result.content)
                    }
                    
                    self.reviewCount = result.reviewCount
                    
                    self.isLast = result.last
                    
                    if !self.isLast, let lastItem = self.myCourseReviews.last {
                        self.lastReviewId = lastItem.reviewId
                    }
                    
                    print("🎯 Parsed Response Data: \(result)")
                }
            })
            .store(in: &cancellables)
    }
    
    /// 삭제 팝업 띄우기
    func openDeletePopup(reviewId: Int) {
        selectedReviewIdForDeletion = reviewId
        showDeletePopup = true
    }
    
    /// 삭제 취소 (팝업 닫기)
    func cancelDeletePopup() {
        showDeletePopup = false
        selectedReviewIdForDeletion = nil
    }
    
    /// 리뷰 삭제 API
    func deleteReview() {
        guard let reviewId = selectedReviewIdForDeletion, !isMyCourseReviewsLoading else { return }
        
        isDeletingReview = true
        
        container.useCaseProvider.myPageUseCase.executeDeleteReview(reviewId: reviewId, reviewType: .course)
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
                    self.myCourseReviews.removeAll { $0.reviewId == reviewId }
                }
                
                self.reviewCount -= 1
                self.cancelDeletePopup()
            })
            .store(in: &cancellables)
    }
}

