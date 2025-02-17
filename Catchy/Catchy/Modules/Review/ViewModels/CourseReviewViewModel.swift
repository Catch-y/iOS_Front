//
//  CourseReviewViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 2/17/25.
//

import Foundation
import Combine

class CourseReviewViewModel: ObservableObject {
    
    @Published var courseReviewData: CourseReviewInfoResponse?
    @Published var isLoading: Bool = false
    
    let container: DIContainer
    var cancellables = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
}
