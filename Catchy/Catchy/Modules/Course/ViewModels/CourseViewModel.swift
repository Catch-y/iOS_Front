//
//  CourseViewModel.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import Foundation
import SwiftUI

class CourseViewModel: ObservableObject{
    
    
    // MARK: - Properties
    
//    let container : DIContainer
    
    /// 코스 리스트
    @Published var courseList: [CourseResponse] = []
    
    /// 코스 타입
    @Published var segment: CourseSegment = .diy
    
    /// 코스 도
    /// ex) 서울특별시, 인천광역시
    /// nil일 경우 모두 조회
    @Published var upperLocation: AddressResponse?
    
    /// 코스 시/군/구
    /// ex) 서울특별시 동작구, 서울특별시 관악구
    /// nil일 경우 모두 조회
    @Published var lowerLocation: AddressResponse?
    
    /// 플로팅 버튼 상태
    @Published var isOpen: Bool = false
    
    /// 드랍 다운 메뉴 상태
    @Published var isDrop: Bool = false 
    
    // MARK: - Init
    
//    init(container: DIContainer){
//        self.container = container
//    }

}

final class dummnyCourseViewModel{
    
    static func dummy() -> CourseViewModel{
        let viewModel = CourseViewModel()
    

//        viewModel.courseList = [
//            CourseResponse(
//                    courseId: 1,
//                    courseType: .diy,
//                    courseImage: "https://i.namu.wiki/i/sopEHIQMRri9OEV0gBMh2xV0WVKv8yKvGB_-9A14bpRhRKNKJG8xCOtiN7yUuyETF52H_aKS3gTxjFHNge6yQLV5dSL8nTzGY79D8ygwut5gTvPb52s3l2a8DIKXcahnJC6RE9L_-6uL4tTCoY5W6g.webp",
//                    courseName: "한강 걷기 코스한강을 따라 걷는 코스입니다.",
//                    courseDescription: "한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.",
//                    categorise: [.SPORT, .BAR, .CULTURELIFE, .REST, .RESTAURANT],
//                    createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 2,
//                courseType: .diy,
//                courseImage: "image2.jpg",
//                courseName: "북촌 한옥마을 투어",
//                courseDescription: "전통 한옥을 체험할 수 있는 투어입니다.",
//                categorise: [.CULTURELIFE, .REST],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 3,
//                courseType: .diy,
//                courseImage: "image3.jpg",
//                courseName: "이태원 카페 탐방",
//                courseDescription: "이태원의 다양한 카페를 둘러보는 코스입니다.",
//                categorise: [.CAFE, .BAR, .RESTAURANT],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 4,
//                courseType: .diy,
//                courseImage: "image4.jpg",
//                courseName: "도심 속 힐링 코스",
//                courseDescription: "도심에서 휴식을 즐길 수 있는 코스입니다.",
//                categorise: [.REST, .SPORT, .EXPRERIENCE, .CULTURELIFE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 5,
//                courseType: .diy,
//                courseImage: "image5.jpg",
//                courseName: "강릉 바다 맛집 코스",
//                courseDescription: "강릉에서 맛집과 함께 바다를 즐길 수 있는 코스입니다.",
//                categorise: [.RESTAURANT, .CAFE, .BAR, .EXPRERIENCE, .CULTURELIFE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 6,
//                courseType: .diy,
//                courseImage: "image6.jpg",
//                courseName: "남산 둘레길 걷기",
//                courseDescription: "남산을 둘러보는 코스입니다.",
//                categorise: [.SPORT],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 7,
//                courseType: .diy,
//                courseImage: "image7.jpg",
//                courseName: "서울 야경 투어",
//                courseDescription: "서울의 야경을 즐길 수 있는 코스입니다.",
//                categorise: [.CULTURELIFE, .REST],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 8,
//                courseType: .diy,
//                courseImage: "image8.jpg",
//                courseName: "강남 맛집 투어",
//                courseDescription: "강남의 숨은 맛집을 탐방하는 코스입니다.",
//                categorise: [.RESTAURANT, .CAFE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 9,
//                courseType: .diy,
//                courseImage: "image9.jpg",
//                courseName: "한강 자전거 코스",
//                courseDescription: "한강을 따라 자전거를 탈 수 있는 코스입니다.",
//                categorise: [.SPORT, .REST],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 10,
//                courseType: .diy,
//                courseImage: "image10.jpg",
//                courseName: "인사동 전통 체험",
//                courseDescription: "인사동에서 전통 체험을 즐길 수 있는 코스입니다.",
//                categorise: [.EXPRERIENCE, .CULTURELIFE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 11,
//                courseType: .diy,
//                courseImage: "image11.jpg",
//                courseName: "부산 해운대 힐링",
//                courseDescription: "해운대에서 힐링을 즐길 수 있는 코스입니다.",
//                categorise: [.REST],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 12,
//                courseType: .diy,
//                courseImage: "image12.jpg",
//                courseName: "제주 오름 탐방",
//                courseDescription: "제주의 아름다운 오름을 탐방하는 코스입니다.",
//                categorise: [.SPORT, .EXPRERIENCE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 13,
//                courseType: .diy,
//                courseImage: "image13.jpg",
//                courseName: "영화 촬영지 투어",
//                courseDescription: "영화 촬영지로 유명한 곳을 방문하는 코스입니다.",
//                categorise: [.CULTURELIFE, .EXPRERIENCE, .REST],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 14,
//                courseType: .diy,
//                courseImage: "image14.jpg",
//                courseName: "산악 등반 코스",
//                courseDescription: "산악을 등반하며 자연을 만끽하는 코스입니다.",
//                categorise: [.SPORT],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 15,
//                courseType: .diy,
//                courseImage: "image15.jpg",
//                courseName: "전주 한옥마을 코스",
//                courseDescription: "전주의 전통 한옥마을을 탐방하는 코스입니다.",
//                categorise: [.CULTURELIFE, .RESTAURANT],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 16,
//                courseType: .diy,
//                courseImage: "image16.jpg",
//                courseName: "강원도 스키 코스",
//                courseDescription: "강원도에서 스키를 즐길 수 있는 코스입니다.",
//                categorise: [.SPORT, .REST],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 17,
//                courseType: .diy,
//                courseImage: "image17.jpg",
//                courseName: "서울 마라톤 코스",
//                courseDescription: "서울에서 마라톤을 경험할 수 있는 코스입니다.",
//                categorise: [.SPORT, .EXPRERIENCE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 18,
//                courseType: .diy,
//                courseImage: "image18.jpg",
//                courseName: "부산 야경 투어",
//                courseDescription: "부산의 아름다운 야경을 즐기는 코스입니다.",
//                categorise: [.REST, .CULTURELIFE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 19,
//                courseType: .diy,
//                courseImage: "image19.jpg",
//                courseName: "영남 알프스 트레킹",
//                courseDescription: "영남 알프스를 트레킹하며 자연을 만끽하는 코스입니다.",
//                categorise: [.SPORT, .EXPRERIENCE],
//                createdDate: Date()
//            ),
//            CourseResponse(
//                courseId: 20,
//                courseType: .diy,
//                courseImage: "image20.jpg",
//                courseName: "도심 속 갤러리 투어",
//                courseDescription: "도심 속 갤러리를 방문하며 예술을 감상하는 코스입니다.",
//                categorise: [.CULTURELIFE],
//                createdDate: Date()
//            )
//        ]
        
        return viewModel
    }
}
