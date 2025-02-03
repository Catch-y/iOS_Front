//
//  NicknameEditViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import SwiftUI
import Combine

class NicknameEditViewModel: ObservableObject {
    
    @Published var nickname: String = ""  // 닉네임 입력 값
    @Published var isDuplicateChecked: Bool = false  // 중복 확인 여부
    @Published var isLoading: Bool = false  // API 로딩 상태
    
    private var cancellables = Set<AnyCancellable>()
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension NicknameEditViewModel {
    
}
