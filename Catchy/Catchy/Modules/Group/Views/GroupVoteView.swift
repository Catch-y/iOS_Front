//
//  GroupVoteView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI

// MARK: - GroupVoteView
struct GroupVoteView: View {
    @StateObject private var viewModel = VoteViewModel()

    var body: some View {
        VStack(spacing: 0) {
            GroupNavigation(title: "투표하기") {
                print("뒤로가기 버튼 클릭") //네비게이션 사용
            }

            VStack(alignment: .leading, spacing: 20) {
                GroupAvatarView(avatars: viewModel.avatars) // GroupAvatarView 사용
                    .padding(.top, 25) // 네비게이션과의 간격 추가

                emptyState()
                    .padding(.top, 29)

                startVoteButton()
                    .padding(.top, 15)
                Spacer()
            }
            .padding(.horizontal, 16) // 전체 좌우 여백
            .background(.bg2) // 전체 배경색 적용
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
        .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬
        .padding(.leading, 16)
    }

    // MARK: - Start Vote Button
    private func startVoteButton() -> some View {
        Button(action: {
            print("투표 시작하기 버튼 클릭")
            // TODO: - 버튼 기능 구현하기
        }) {
            VStack {
                Image("voteStartButton")
                    .foregroundStyle(.g3)
                Text("투표 시작하기")
                    .foregroundStyle(.g3)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity) // 너비를 화면 가득 채움
            .frame(height: 95)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - Preview
struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        GroupVoteView()
    }
}

