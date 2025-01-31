//
//  VoteRankViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import SwiftUI

class VoteRankViewModel: ObservableObject {
    @Published var ranks: [(name: String, count: Int, avatars: [String])] = []

    init() {
        loadRanks()
    }

    func loadRanks() {
        ranks = [
            ("카페", 2, ["avatar1", "avatar2"]),
            ("주류", 5, ["avatar1", "avatar3", "avatar4"]),
            ("스포츠", 3, ["avatar2", "avatar3"])
        ]
    }
}
