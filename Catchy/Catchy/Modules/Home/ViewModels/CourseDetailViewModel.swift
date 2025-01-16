//
//  CouseDetailViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/16/25.
//

import Foundation

class CourseDetailViewModel: ObservableObject {
    @Published var courseDetailResponse: CourseDetailResponse?
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
