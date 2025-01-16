//
//  CouseDetailViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/16/25.
//

import Foundation

class CourseDetailViewModel: ObservableObject {
    @Published var courseDetailResponse: CourseDetailResponse? = .init(courseId: 0, courseImage: "https://i.namu.wiki/i/8e3D_7TuMif2-Zbntb81t0LRFy6HqiWZexiXb2JrGBt4IX7NB9R0zZa4JmV3yaOigoOYlxQCWH5RJAXNXuYctV-xEGg9HzgI0cTlsVQPwmTI6FwSSkCWYIx5SJGf0d7Yyzu2HjDJczahbUiqhrFNcQ.webp", courseName: "경복궁", courseDescription: "코스 설명은 두 줄 정도로 정리 길이 테스트 두 줄로 정렬하면 이 정도 간격으로 최대 길이는 이 정도로 ?", courseType: .user, rating: 4.3, reviewCount: 203, recommendTime: "15:00 ~ 20:00", participantsNumber: 25, isBookmark: false, placeInfos: [.init(placeId: 0, placeName: "dkdk", placeLatitude: 1.2, placeLongitude: 1.2, isVisited: false)])
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
