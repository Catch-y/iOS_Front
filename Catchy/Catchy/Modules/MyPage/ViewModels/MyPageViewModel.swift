//
//  MyPageViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI
import Combine

class MyPageViewModel: ObservableObject {
    
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - MyPage View Properties
    
    /// 마이페이지 response
    @Published var courseResponse: CourseResponse?
    
    /// 마이페이지 response 로딩 중?
    @Published var isLoading: Bool = false

    // MARK: - Init
    
    init(container: DIContainer) {
        self.container = container
    }
}

extension MyPageViewModel {
    
    // MARK: - API 호출 함수
}

