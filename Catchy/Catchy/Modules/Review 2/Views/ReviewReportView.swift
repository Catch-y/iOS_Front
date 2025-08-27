//
//  ReviewReport.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import SwiftUI
import Kingfisher

struct ReviewReportView: View {
    
    @StateObject var viewModel: ReviewReportViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 33, content: {
            CustomNavigation(action: {
                print("hello")
            }, title: "리뷰 신고하기", leftNaviIcon: nil, isShadow: true)
            VStack(content: {
                reviewReportItems()
                
                Spacer()
                
                MainBtn(
                    text: "신고하기",
                    action: {
                        viewModel.postReviewReportInfo(reviewId: 123, request: ReviewReportRequest(reviewType: .place, reason: "부적절한 내용입니다."))
                    },
                    width: UIScreen.screenWidth-32,
                    height: 60,
                    onoff: viewModel.selectedReasons.isEmpty ? .off : .on
                )
                .padding(.bottom, 46)
            })
            .padding(.horizontal, 16)
        })
        .ignoresSafeArea(.all)
    }
    // MARK: - 상단 리뷰 신고하기 항목들
    
    /// 리뷰 신고 항목 뷰
    /// - Returns: 리뷰 신고 항목 뷰
    private func reviewReportItems() -> some View {
        return VStack(alignment: .leading, spacing: 27,content: {
            ForEach(ReviewReportReason.allCases, id: \.self) { reason in
                ReportItem(
                    reason: reason,
                    isSelected: viewModel.selectedReasons.contains(reason),
                    onSelect: {
                        if viewModel.selectedReasons.contains(reason) {
                            viewModel.selectedReasons.removeAll { $0 == reason }
                        } else {
                            viewModel.selectedReasons.append(reason)
                        }
                    }
                )
            }
            /* 직접 입력 텍스트 칸 */
            /* 기존 TextEditor 코드 변경 */
            TextEditor(text: $viewModel.customReasonText)
                .customStyleTipsEditor(
                    text: $viewModel.customReasonText,
                    placeholder: "",
                    maxTextCount: 300, border: .g1
                )
                .frame(height: 130)
                .disabled(!viewModel.selectedReasons.contains(.customInput)) /* 직접 입력이 선택되지 않으면 비활성화 */
                .opacity(viewModel.selectedReasons.contains(.customInput) ? 1.0 : 0.5) /* 비활성화 시 시각적 효과 추가 */
        })
    }
}
struct ReviewReportView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ReviewReportView(container: DIContainer())
                .environmentObject(DIContainer())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
