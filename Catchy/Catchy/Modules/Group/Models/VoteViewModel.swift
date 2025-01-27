//
//  VoteViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import Combine

class VoteViewModel: ObservableObject {
    @Published var avatars: [UserAvatarModel] = []

    init() {
        loadMockData()
    }

    private func loadMockData() {
        avatars = [
            UserAvatarModel(imageName: "avatar1"),
            UserAvatarModel(imageName: "avatar2"),
            UserAvatarModel(imageName: "avatar3"),
            UserAvatarModel(imageName: "avatar4")
        ]
    }
}
