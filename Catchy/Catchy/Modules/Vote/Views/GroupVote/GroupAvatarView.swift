//
//  GroupAvatarView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI
import Kingfisher

struct GroupAvatarView: View {
    
    @StateObject private var viewModel = GroupAvatarViewModel()
    let groupId: Int // 그룹 ID
    
    // MARK: - Body
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.g3)
            } else if viewModel.avatars.isEmpty {
                Text("No avatars available")
                    .foregroundStyle(.g3)
            } else {
                HStack(spacing: 12) {
                    ForEach(viewModel.avatars, id: \.id) { avatar in
                        VStack {
                            if avatar.imageName.starts(with: "http") {  //  URL 이미지 (서버)
                                KFImage(URL(string: avatar.imageName))
                                    .placeholder {
                                        Circle()
                                            .fill(Color.bg1) // 로딩 중 배경
                                            .frame(width: 63, height: 63)
                                    }
                                    .scaledToFit()
                                    .frame(width: 63, height: 63)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            } else {  //  로컬 에셋 이미지 (샘플 데이터)
                                Image(avatar.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 63, height: 63)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 23)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 85))

            }
        }
        .onAppear {
            viewModel.fetchGroupMembers(groupId: groupId)
        }
    }
}

// MARK: - Preview
struct GroupAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        GroupAvatarView(groupId: 1)
            .background(.blue)
    }
}
