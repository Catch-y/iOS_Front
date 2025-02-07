//
//  MyReviewView.swift
//  Catchy
//
//  Created by 권용빈 on 2/6/25.
//

import SwiftUI

struct MyReviewsView: View {
    
    @StateObject var viewModel: MyReviewsViewModel
    @Namespace private var animationNamespace
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 22, content: {
            if !viewModel.isLoading {
                CustomNavigation(action: {
                    print("hello")
                }, title: "내 리뷰", rightNaviIcon: nil, isShadow: true)
                if let data = viewModel.myReviewsData {
                    segmentSection()
                    
                    contentSection(data: data)
                        .padding(.horizontal, 16)
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
        .ignoresSafeArea()
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .task {
            viewModel.getMyReviews(review: .init(reviewType: ReviewType.place, pageSize: 10, lastReviewId: 1))
        }
    }
    
    /// 세그먼트 UI 함수
    private func segmentSection() -> some View {
        ZStack(alignment: .leading) {
            /// 전체 배경 Capsule (테두리)
            RoundedRectangle(cornerRadius: 21.5)
                .stroke(Color.g3, lineWidth: 1)
                .frame(width: 287, height: 40)
            
            /// 선택된 항목만 둥근 사각형 배경 표시
            HStack {
                if viewModel.selectedSegment == .place {
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 21.5)
                    .fill(Color.m5)
                    .frame(width: 140, height: 32)
                    .padding(4)
                    .matchedGeometryEffect(id: "Tab", in: animationNamespace)
                
                if viewModel.selectedSegment == .course {
                    Spacer()
                }
            }
            .frame(width: 287, height: 40)
            
            /// 세그먼트 버튼들
            HStack(spacing: 0) {
                ForEach(ReviewSegment.allCases, id: \.self) { segment in
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            viewModel.selectedSegment = segment
                        }
                    } label: {
                        Text(segment.segmentTitle)
                            .font(.body1)
                            .frame(width: 140, height: 32)
                            .foregroundStyle(viewModel.selectedSegment == segment ? Color.white : Color.g5)
                    }
                }
            }
            .frame(width: 287, height: 40)
        }
    }

    private func contentSection(data: MyReviewResponse) -> some View {
        VStack(alignment: .leading, spacing: 22, content: {
            reviewCountSection(count: data.reviewCount)    // "작성한 리뷰 개수" 표시
            reviewTableSection(content: data.content)  // 리뷰 목록 표시
        })
    }
    
    private func reviewCountSection(count: Int) -> some View {
            return HStack(spacing: 9, content: {
                Text("작성한 리뷰")
                    .font(.body2)
                    .foregroundStyle(Color.g6)
                Text("\(count)")
                    .font(.body2)
                    .foregroundStyle(Color.m6)
        })
    }
    
    private func reviewTableSection(content: [ReviewDataProtocol]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {  // 🔹 LazyVStack으로 성능 최적화
                ForEach(content, id: \.reviewId) { review in
                    ReviewCard(data: review, cardType: .myReview, reviewType: .course)
                    if review.reviewId != content.last?.reviewId {
                        Divider()
                            .background(Color.g3)
                            .padding(.vertical, 40)
                    }
                }
            }
        }
    }
    
}

struct MyReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            MyReviewsView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
