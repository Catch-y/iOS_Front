//
//  GroupVoteStartViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import SwiftUI
import Combine

class GroupVoteStartViewModel: ObservableObject {
    
    // MARK: - Properties
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    @Published var title: String = "투표하기"
    @Published var groupId: Int
    @Published var voteId: Int
    
    // MARK: - Initializer
    init(container: DIContainer, groupId: Int, voteId: Int) {
        self.container = container
        self.groupId = groupId
        self.voteId = voteId
    }
}
