//
//  MyReviewsViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/6/25.
//

import SwiftUI
import Combine

class MyReviewsViewModel: ObservableObject {
    
    /// 내 리뷰 조회 API 로딩중?
    @Published var isMyReviewsLoading: Bool = false
    
    /// 선택된 세그먼트
    @Published var selectedSegment: ReviewSegment = .course
    
    /// 삭제 팝업 창 상태
    @Published var showDeletePopup: Bool = false
    
    /// 삭제할 리뷰 ID
    @Published var selectedReviewIdForDeletion: Int? = nil
    
    /// 리뷰 삭제 API 로딩 상태
    @Published var isDeletingReview: Bool = false
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyReviewsViewModel {
    
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
}
