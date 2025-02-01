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
            if !viewModel.isLoading {
                if viewModel.reviewReportData != nil {
                    CustomNavigation(action: {
                        print("hello")
                    }, title: "리뷰 신고하기", leftNaviIcon: nil)
                    .s1w()
                    
                    reviewReportItems()
                    
                    Spacer()
                    
                    MainBtn(
                        text: "신고하기",
                        action: {
                            // submitReport()
                        },
                        width: UIScreen.main.bounds.width - 32,
                        height: 60,
                        onoff: viewModel.selectedReasons.isEmpty ? .off : .on
                    )
                    .padding(.bottom, 46) // 버튼과 화면 하단 간격
                } else {
                    // 값을 들고 있지 않다면 가이드 보여주기
                }
            } else {
                Spacer()
                
                ProgressView()
                    .controlSize(.regular)
                
                Spacer()
            }
        })
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .task {
            viewModel.postReviewReportInfo(reviewReportRequest: .init(reviewId: 1, reviewType: .course, reason: .copyrightViolation))
        }
    }
    // MARK: - 상단 리뷰 신고하기 항목들
    
    private func reviewReportItems() -> some View {
        return VStack(alignment: .leading, spacing: 27,content: {
            ForEach(ReviewReportReason.allCases, id: \.self) { reason in
                ReportItem(
                    reason: reason,
                    isSelected: viewModel.selectedReasons.contains(reason), // 선택 여부 확인
                    onSelect: {
                        if viewModel.selectedReasons.contains(reason) {
                            // 이미 선택된 항목이면 선택 해제
                            viewModel.selectedReasons.removeAll { $0 == reason }
                        } else {
                            // 선택되지 않은 항목이면 추가
                            viewModel.selectedReasons.append(reason)
                        }
                    }
                )
            }
            // 직접 입력 텍스트 칸
            // 기존 TextEditor 코드 변경
            TextEditor(text: $viewModel.customReasonText)
                .customStyleTipsEditor(
                    text: $viewModel.customReasonText,
                    placeholder: "",
                    maxTextCount: 300, border: .g1
                )
                .frame(height: 130)
                .disabled(!viewModel.selectedReasons.contains(.customInput)) // 직접 입력이 선택되지 않으면 비활성화
                .opacity(viewModel.selectedReasons.contains(.customInput) ? 1.0 : 0.5) // 비활성화 시 시각적 효과 추가

            .padding(.horizontal, 16)
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
