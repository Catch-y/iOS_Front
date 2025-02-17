//
//  NicknameEditViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import SwiftUI
import Combine

class NicknameEditViewModel: ObservableObject {
    
    /// 닉네임 입력 값
    @Published var nickname: String = ""
    
    /// 중복 확인 여부
    @Published var isDuplicateChecked: Bool = false
    
    
    
    private var cancellables = Set<AnyCancellable>()
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension NicknameEditViewModel {
    
}
