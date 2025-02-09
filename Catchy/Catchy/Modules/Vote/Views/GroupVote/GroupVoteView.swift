//
//  GroupVoteView.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import SwiftUI

struct GroupVoteView: View {
    
    @StateObject private var viewModel: VoteViewModel
    @State private var isPopupVisible: Bool = false // 팝업 표시 상태 관리

    init(container: DIContainer, groupID: Int) {
        self._viewModel = StateObject(wrappedValue: VoteViewModel(container: container, groupID: groupID))
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GroupNavigation(title: "투표하기") {
                    print("뒤로가기 버튼 클릭")
                }

                VStack(spacing: 20) {
                    // GroupAvatarView에서 groupID 전달
                    GroupAvatarView(groupId: viewModel.groupID)
                        .padding(.top, 25)

                    emptyState()
                        .padding(.top, 29)

                    startVoteButton()
                        .padding(.top, 15)

                    Spacer()
                }
                .padding(.horizontal, 16)
                .background(.bg2)
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
                            // String 배열을 CategoryType 배열로 변환 후 ViewModel에 전달
                            let selectedCategories = selectedCategoryNames.compactMap { CategoryType(rawValue: $0) }
                            viewModel.updateCategories(with: selectedCategories)
                        }
                    )

                    .frame(width: 350, height: 783) // 팝업 크기
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                }
                .transition(.scale) // 팝업 애니메이션
                .animation(.easeInOut, value: isPopupVisible)
            }
        }
    }

    // MARK: - Empty State
    private func emptyState() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("아직 생성된 투표가 없어요")
                .font(.Subtitle3)
                .foregroundStyle(.g6)
            Text("빠르게 투표를 시작해보세요!")
                .font(.Subtitle3)
                .foregroundStyle(.g6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
    }

    // MARK: - Start Vote Button
    private func startVoteButton() -> some View {
        Button(action: {
            isPopupVisible = true // 팝업 표시
        }) {
            VStack {
                Image("voteStartButton")
                    .foregroundStyle(.g4)
                Text("투표 시작하기")
                    .font(.body3)
                    .foregroundStyle(.g4)
                    .padding(.top, 8)
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 95)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - Preview
struct GroupVoteView_Previews: PreviewProvider {
    static var previews: some View {
        GroupVoteView(container: DIContainer(), groupID: 1)
    }
}
