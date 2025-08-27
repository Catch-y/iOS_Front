//
//  DeleteReviewPopupView.swift
//  Catchy
//
//  Created by 권용빈 on 2/19/25.
//

import SwiftUI

struct DeleteReviewPopupView: View {
    
    @ObservedObject var viewModel: MyReviewsViewModel
    @ObservedObject var courseReviewsViewModel: MyCourseReviewsViewModel
    @ObservedObject var placeReviewsViewModel: MyPlaceReviewsViewModel
    
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 13, content: {
                Icon.warningIntro.image
                
                textSection()
                    .padding(.bottom, 9)
                
                buttonSeciton()
                
            })
            .frame(maxWidth: .infinity)
            .frame(height: 192)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            }
            .padding(.horizontal, 16)
        }
    }
    
    /// 리뷰 삭제 메시지 텍스트 섹션
    /// - Returns: 텍스트 뷰
    private func textSection() -> some View {
        return VStack(spacing: 5, content: {
            (
                Text("리뷰를 ")
                + Text("삭제").foregroundColor(.m6)
                + Text(" 하시겠습니까?")
            )
            .font(.Subtitle3)
            .foregroundStyle(Color.g7)
            
            Text("리뷰를 삭제하면 다시 복구할 수 없어요.")
                .font(.body3)
                .foregroundStyle(Color.g4)
        })
    }
    
    /// 버튼 섹션
    /// - Returns: 취소 / 확인 버튼 섹션 뷰
    private func buttonSeciton() -> some View {
        return HStack(spacing: 15, content: {
            Button(action: {
                viewModel.cancelDeletePopup()
            }) {
                Text("취소")
                    .font(.body3)
                    .foregroundStyle(Color.g5)
                    .frame(width: 136, height: 38)
                    .background(.g2)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
            }
            Button(action: {
                deleteReview()
            }) {
                Text("확인")
                    .font(.body3)
                    .foregroundStyle(Color.white)
                    .frame(width: 136, height: 38)
                    .background(.m5)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
            }
        })
    }
}

extension DeleteReviewPopupView {
    func deleteReview() {
        guard let reviewId = viewModel.selectedReviewIdForDeletion else {
            return
        }
        viewModel.isDeletingReview = true
        
        if viewModel.selectedSegment == .course {
            courseReviewsViewModel.deleteReview(reviewId: reviewId) { result in
                if result {
                    viewModel.cancelDeletePopup()
                    viewModel.isDeletingReview = false
                }
            }
        } else {
            placeReviewsViewModel.deleteReview(reviewId: reviewId) {
                viewModel.cancelDeletePopup()
                viewModel.isDeletingReview = false
            }
        }
    }
}
