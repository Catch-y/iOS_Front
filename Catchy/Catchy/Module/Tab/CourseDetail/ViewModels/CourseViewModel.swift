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
    var courseDetail: CourseGenerateUserResponse? = .init(
        courseId: 0,
        courseImage: "https://i.namu.wiki/i/Gc-iRxDS_rz8040Rpoin7pvpuEhXgYCWFqwKNXMqb-xz322o0PllwsnjeC3yjgSo8sjaxBtTbUuw5xDfp2_r72x5GtuW9rTtFaR30zVAi4UlnblRfoJ2XEBQyPfEZbtEn2LqUZZPdEsFu5nQICjxAg.webp",
        courseName: "크리스마스 무드 로맨틱 데이트 코스",
        courseDescription: "코스 설명은 두 줄 정도로 정리.\n길이 테스트를 위해 두 줄로 정렬하면 이 정도 간격으로 최대 길이는 이 정도로?",
        courseType: .ai,
        rating: 4.8,
        reviewCount: 5,
        recommendTime: "11:00 - 16:00",
        participantsNumber: 2,
        isBookMarked: false,
        placeInfos: [
            // 1. 기존 장소 (시청역 인근)
            .init(
                placeId: 9,
                placeName: "더미 장소 1",
                category: .BAR,
                placeLatitude: 37.5665,
                placeLongitude: 126.9780,
                isVisited: true // 첫 번째는 방문했다고 가정
            ),
            
            // 2. 추가 장소 A (청계천 근처 카페)
            .init(
                placeId: 10,
                placeName: "블루보틀 광화문",
                category: .CAFE,
                placeLatitude: 37.5693,
                placeLongitude: 126.9778,
                isVisited: false
            ),
            
            // 3. 추가 장소 B (을지로 맛집)
            .init(
                placeId: 11,
                placeName: "녁 (NYUG)",
                category: .RESTAURANT,
                placeLatitude: 37.5656,
                placeLongitude: 126.9905,
                isVisited: false
            ),
            
            // 4. 추가 장소 C (산책 코스/명동 성당)
            .init(
                placeId: 12,
                placeName: "명동대성당",
                category: .CULTURELIFE, // 혹은 .POINT
                placeLatitude: 37.5631,
                placeLongitude: 126.9873,
                isVisited: false
            )
        ]
    )
    
    let courseId: Int
    
    init(courseId: Int) {
        self.courseId = courseId
    }
}
