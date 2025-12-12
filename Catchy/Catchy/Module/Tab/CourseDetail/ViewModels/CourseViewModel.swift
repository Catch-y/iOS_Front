//
//  CourseViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 12/7/25.
//

import Foundation

@Observable
class CourseViewModel {
    
    // MARK: - StateProperty
    var isShowWarning: Bool = false
    var isLoading: Bool = false
    
    // MARK: - StoreProperty
    var courseDetail: CourseGenerateUserResponse? = .init(courseId: 0, courseImage: "https://i.namu.wiki/i/Gc-iRxDS_rz8040Rpoin7pvpuEhXgYCWFqwKNXMqb-xz322o0PllwsnjeC3yjgSo8sjaxBtTbUuw5xDfp2_r72x5GtuW9rTtFaR30zVAi4UlnblRfoJ2XEBQyPfEZbtEn2LqUZZPdEsFu5nQICjxAg.webp", courseName: "크리스마스 무드 로맨틱 데이트 코스", courseDescription: "코스 설명은 두 줄 정도로 정리 길이 테스트 두 줄로 정렬하면 이 정도 간격으로 최대 길이는 이 정도로 ?", courseType: .ai, rating: 1.0, reviewCount: 1, recommendTime: "11:00 - 16:00", participantsNumber: 1, isBookMarked: false, placeInfos: [
        .init(placeId: 9, placeName: "1", category: .BAR, placeLatitude: 1.0, placeLongitude: 1.0, isVisited: false)
        ])
    
    let courseId: Int
    
    init(courseId: Int) {
        self.courseId = courseId
    }
}
