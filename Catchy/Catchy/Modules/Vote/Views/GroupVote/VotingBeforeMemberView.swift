//
//  VotingBeforeMemberView.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import SwiftUI
import Kingfisher

struct VotingBeforeMemberView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: GroupVoteBeforeMemberViewModel

    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: GroupVoteBeforeMemberViewModel(container: container))
    }

    // MARK: - Body
    var body: some View {
        VStack {
            if viewModel.isVoteMemberLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else if viewModel.avatars.isEmpty {
                infoView
            } else {
                avatarsView
            }
        }
        .task {
            print("투표 멤버 데이터 로드 중")
            viewModel.getVoteMembers(groupId: 1, voteId: 1)
            print("투표 멤버 데이터 로드 완료")
        }
    }
    
    // MARK: - Avatars View
    private var avatarsView: some View {
        HStack(spacing: 12) {
            ForEach(viewModel.avatars, id: \ .image) { avatar in
                VStack {
                    if avatar.image.starts(with: "http") {
                        KFImage(URL(string: avatar.image))
                            .placeholder {
                                Image("placeholder")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 63, height: 63)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Image(avatar.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 63, height: 63)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Image(systemName: avatar.status ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(avatar.status ? .green : .red)
                        .offset(y: -10)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 11)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 85))
    }
    
    // MARK: - 데이터 없을때
    private var infoView: some View {
        Text("투표 멤버가 없습니다.")
            .font(.Subtitle3)
            .foregroundStyle(.g4)
    }
}

// MARK: - Preview
struct VotingBeforeMemberView_Previews: PreviewProvider {
    static var previews: some View {
        VotingBeforeMemberView(container: DIContainer())
            .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro Max"))
            .previewDisplayName("iPhone 16 Pro Max")
            .background(.blue)
    }
       
}
