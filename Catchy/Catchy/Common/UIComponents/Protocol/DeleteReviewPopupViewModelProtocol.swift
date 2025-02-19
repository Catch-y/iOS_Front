//
//  DeleteReviewPopupViewModelProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/19/25.
//

import Foundation

protocol DeleteReviewPopupViewModelProtocol: ObservableObject {
    
    /// 삭제 팝업 창 표시 여부
    var showDeletePopup: Bool { get set }
    
    /// 삭제할 리뷰 ID
    var selectedReviewIdForDeletion: Int? { get set }
    
    /// 리뷰 삭제 API 로딩 상태
    var isDeletingReview: Bool { get set }
    
    /// 삭제 팝업 띄우기
    func openDeletePopup(reviewId: Int)
    
    /// 삭제 팝업 닫기
    func cancelDeletePopup()
    
    /// 리뷰 삭제 실행
    func deleteReview()
}
