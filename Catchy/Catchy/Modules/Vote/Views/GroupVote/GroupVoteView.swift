//
//  GroupVoteView.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import SwiftUI

struct GroupVoteView: View {
    @EnvironmentObject var container: DIContainer
    
    @StateObject private var viewModel: VoteViewModel
    @State private var isPopupVisible: Bool = false // 팝업 표시 상태 관리

    init(container: DIContainer, groupId: Int) {
        self._viewModel = StateObject(wrappedValue: VoteViewModel(container: container, groupId: groupId))
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GroupNavigation(title: "투표하기") {
                    container.navigationRouter.pop()
                }

                VStack(spacing: 20) {
                    // GroupAvatarView에서 groupId 전달
                    GroupAvatarView(groupId: viewModel.groupId)
                        .padding(.top, 25)

                    emptyState()
                        .padding(.top, 29)

                    startVoteButton()
                        .padding(.top, 15)

                    Spacer()
                }
                .padding(.horizontal, 16)
                .background(Color.bg2)
            }
            .padding(.bottom, 110)

            // 팝업 화면
            if isPopupVisible {
                ZStack {
                    // 반투명 배경
                    Color.bg1
                        .ignoresSafeArea()
                        .onTapGesture {
                            isPopupVisible = false // 팝업 닫기
                        }

                    // VotePopupView
                    VotePopupView(
                        dismissAction: {
                            isPopupVisible = false
                        },
                        onComplete: { selectedCategoryNames in
                            // String 배열을 전달 후 API 호출
                            viewModel.updateCategories(with: selectedCategoryNames)
                            viewModel.saveCategoriesToServer(voteId: 123) // 예시 voteId 값 전달
                        }
                    )

                    .frame(maxWidth: .infinity, maxHeight: 783) // 팝업 크기
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal ,16)
                }
                .transition(.scale) // 팝업 애니메이션
                .animation(.easeInOut, value: isPopupVisible)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Empty State
    private func emptyState() -> some View {
        VStack(alignment: .leading) {
            Text("아직 생성된 투표가 없어요 \n빠르게 투표를 시작해보세요!")
                .font(.Subtitle3)
                .bold()
                .foregroundStyle(.g6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Start Vote Button
    private func startVoteButton() -> some View {
        Button(action: {
            isPopupVisible = true // 팝업 표시
        }) {
            VStack(spacing : 8) {
                Icon.votePlusButton.image
                    .foregroundStyle(.g4)
                Text("투표 시작하기")
                    .font(.body3)
                    .foregroundStyle(.g4)
                    
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 95)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }
    }
}

// MARK: - Preview
struct GroupVoteView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            NavigationView {
                GroupVoteView(container: DIContainer(), groupId: 1)
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
