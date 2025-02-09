//
//  HomeViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var courseInfoResponse: [CourseInfoResponse]? /* 찻 번째 섹션 */
    @Published var popularCourseResponse: [PopularCourseResponse]? /* 두 번째 섹션 */
    @Published var recommendPlaceResponse: [RecommendPlaceResponse]? /* 세 번째 섹션 */

    
    @Published var popularCourseIndex: Int = 1
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
