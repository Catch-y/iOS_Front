//
//  MyReviewsViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/6/25.
//

import SwiftUI
import Combine

class MyReviewsViewModel: ObservableObject {
    
    /// 내 리뷰 조회 API 로딩중?
    @Published var isMyReviewsLoading: Bool = false
    
    /// 선택된 세그먼트
    @Published var selectedSegment: ReviewSegment = .course
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}
