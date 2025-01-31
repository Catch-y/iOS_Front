//
//  GroupVoteView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI



// MARK: - GroupVoteView
struct GroupVoteView: View {
    @StateObject private var viewModel: VoteViewModel

    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: VoteViewModel(container: container))
    }

    var body: some View {
        VStack(spacing: 0) {
            GroupNavigation(title: "투표하기") {
                print("뒤로가기 버튼 클릭")
            }

            VStack(spacing: 20) {
                // GroupAvatarView에서 avatars 전달
                GroupAvatarView(avatars: viewModel.avatars)
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
    }

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

    private func startVoteButton() -> some View {
        Button(action: {
            print("투표 시작하기 버튼 클릭")
        }) {
            VStack {
                Image("voteStartButton")
                    .foregroundStyle(.g3)
                Text("투표 시작하기")
                    .foregroundStyle(.g3)
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
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            GroupVoteView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

