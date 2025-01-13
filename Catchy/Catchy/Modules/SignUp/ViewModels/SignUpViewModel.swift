//
//  SignUpViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var nickname: String = ""
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
