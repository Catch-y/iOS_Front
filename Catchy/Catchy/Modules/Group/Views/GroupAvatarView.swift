//
//  GroupAvatarView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI

struct GroupAvatarView: View {
    let avatars: [UserAvatarModel] // 아바타 리스트

    var body: some View {
        HStack(spacing: 12) { // 아바타 간 간격 12 유지
            ForEach(avatars) { avatar in
                Image(avatar.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 63, height: 63) // 아바타 크기 고정
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(.horizontal, 41) // 아바타와 프레임 사이 좌우 간격 41
        .padding(.vertical, 23)   // 아바타와 프레임 사이 상하 간격 23
        .background(Color.white) // 배경색 흰색
        .clipShape(RoundedRectangle(cornerRadius: 85)) // 외부 곡선 설정
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // 그림자
    }
}

struct GroupAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        let mockAvatars = [
            UserAvatarModel(imageName: "avatar1"),
            UserAvatarModel(imageName: "avatar2"),
            UserAvatarModel(imageName: "avatar3"),
            UserAvatarModel(imageName: "avatar4")
        ]
        GroupAvatarView(avatars: mockAvatars)
    }
}

