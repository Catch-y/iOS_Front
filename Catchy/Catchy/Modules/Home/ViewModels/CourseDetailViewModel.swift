//
//  CourseViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import Foundation

class CourseDetailViewModel: ObservableObject {
    
    @Published var courseEditResponse: CourseEditResponse? = .init(courseId: 1, courseImage: "https://i.namu.wiki/i/Ca6uA8jti6jQfstU5FzeSH6bnn9Ms8uoWBMROytYU606IZ0GLj4d8RWEAQpV3PUP1FjsuemL2y-QlMwp-m1JiQl-ZXmKvkKDfsFNK93VrWiFP9Tv7Yz71eOmMJnBKGHfQEFIfGODpVi3lwxEll8eAw.webp", courseName: "경복궁", courseDescription: "코스 설명은 두 줄정도로 정리 길이 테스트, 두 줄로 정렬하면 이 정도 간격으로 최대 길이는 이 정도로 ?", courseType: "AI", rating: 4.3, reviewCount: 203, recommendTime: "15:00 - 20:00", participantsNumber: 25, isBookMarked: true, placeInfos: [.init(placeId: 0, placeName: "11", placeLatitude: 1.1, placeLongitude: 1.1, isVisited: false)])
    
    @Published var showAlert: Bool = false
    
    let courseId: Int
    let container: DIContainer
    
    init(container: DIContainer, courseId: Int) {
        self.container = container
        self.courseId = courseId
    }
}
