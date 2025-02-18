//
//  MyReviewView.swift
//  Catchy
//
//  Created by 권용빈 on 2/6/25.
//

import SwiftUI

/// 사용자가 작성한 리뷰 목록을 보여주는 화면
struct MyReviewsView: View {
    
    @StateObject var viewModel: MyReviewsViewModel
    @Namespace private var animationNamespace
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 22, content: {
            if !viewModel.isMyReviewsLoading {
                CustomNavigation(action: {
                    print("hello")
                }, title: "내 리뷰", rightNaviIcon: nil, isShadow: true)
                segmentSection()
                    .padding(.bottom, 4)
                
                if viewModel.selectedSegment == .course {
                    MyCourseReviewsView(container: DIContainer())
                } else {
                    MyPlaceReviewsView(container: DIContainer())
                }
            } else {
                LoadingView()
            }
        })
        .ignoresSafeArea()
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - 세그먼트 UI
    
    /// 리뷰 유형 선택을 위한 세그먼트 뷰 (코스 / 장소)
    /// - Returns: 코스 리뷰 / 장소 리뷰 선택 UI
    private func segmentSection() -> some View {
        ZStack(alignment: .leading) {
            /* 전체 배경 Capsule (테두리) */
            RoundedRectangle(cornerRadius: 21.5)
                .stroke(Color.g3, lineWidth: 1)
                .frame(width: 287, height: 40)
            
            /* 선택된 항목만 둥근 사각형 배경 표시 */
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
            
            /* 세그먼트 버튼들 */
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
