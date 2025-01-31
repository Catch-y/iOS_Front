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
    
    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
    }
}

