//
//  ReviewRegisterView.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import Foundation
import SwiftUI
import Combine
import CombineMoya

class ReviewRegisterViewModel: ObservableObject {
    
    let container: DIContainer

    var cancellables = Set<AnyCancellable>()
    
    // MARK: - 평점, 리뷰 남기기 Properties
    /// 리뷰 평점
    @Published var rating: Int?
    
    /// 리뷰 코멘트
    @Published var comment: String?
    
    /// 리뷰 방문 날짜
    @Published var visitedDate: String?
    
    
    // TODO: - 이미지 post 처리
    @Published var images: [String]?
    
    
    init(container: DIContainer) {
        self.container = container
    }
    
    
    
}
