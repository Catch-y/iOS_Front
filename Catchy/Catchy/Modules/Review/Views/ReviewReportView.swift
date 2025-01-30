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
    @State private var selectedReasons: [ReviewReportReason] = [] // 선택된 항목 리스트 관리
    @State private var customReasonText: String = "" // 직접 입력 텍스트
    
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
                        onoff: selectedReasons.isEmpty ? .off : .on
                    )
                    .padding(.bottom, 46) // 버튼과 화면 하단 간격
                    // 보일 뷰 작성
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
                    isSelected: selectedReasons.contains(reason), // 선택 여부 확인
                    onSelect: {
                        if selectedReasons.contains(reason) {
                            // 이미 선택된 항목이면 선택 해제
                            selectedReasons.removeAll { $0 == reason }
                        } else {
                            // 선택되지 않은 항목이면 추가
                            selectedReasons.append(reason)
                        }
                    }
                )
            }
            // 직접 입력 텍스트 칸
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $customReasonText)
                    .font(.body)
                    .lineSpacing(6)
                    .padding(10)
                    .frame(height: 130)
                    .background(.g1)
                    .cornerRadius(20)
                    .disabled(!selectedReasons.contains(.customInput)) // 직접 입력이 선택되지 않으면 비활성화
                    .opacity(selectedReasons.contains(.customInput) ? 1.0 : 0.5) // 비활성화 시 시각적 효과 추가
                    .onChange(of: customReasonText) {
                        if customReasonText.count > 300 {
                            customReasonText = String(customReasonText.prefix(300))
                        }
                    }
                
                countTextLabel()
                    .padding(.bottom, 16)
                    .padding(.trailing, 20)
            }
            .padding(.horizontal, 16)
        })
    }
    
    private func countTextLabel() -> some View {
        HStack(spacing: 0) {
            Text("\(customReasonText.count)")
                .font(.body3)
                .foregroundColor(customReasonText.count == 300 ? .pink : .g6) 
            Text(" / 300")
                .font(.body3)
                .foregroundColor(.g4)
        }
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
