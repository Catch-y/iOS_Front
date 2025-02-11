//
//  SettingViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/5/25.
//

import SwiftUI
import Combine

class SettingViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(container: DIContainer) {
        self.container = container
    }
}
