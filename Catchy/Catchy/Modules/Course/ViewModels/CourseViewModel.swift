//
//  CourseViewModel.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import Foundation
import SwiftUI

class CourseViewModel: ObservableObject{
    
    
    //  let container : DIContainer
    
    // MARK: - Course View Properties
    
    /// 코스 리스트
    @Published var courseList: [CourseResponse] = []
    
    // MARK: - Segment Control Properties
    
    /// 코스 타입
    /// 세그먼트 컨트롤의 선택된 커스 타입입니다.
    @Published var segment: CourseSegment = .diy
    
    // MARK: - Dropdown Properties
    
    /// 코스 도
    /// ex) 서울특별시, 인천광역시
    @Published var upperLocations: [LocationResponse] = []
    
    /// 코스 시/군/구
    /// ex) 서울특별시 동작구, 서울특별시 관악구
    @Published var lowerLocations: [LocationResponse] = []
    
    /// 선택된 [코스 도]의 인덱스
    @Published var selectedUpperIndex: Int? = nil
    
    /// 선택된 [코스 시군구]의 인덱스
    @Published var selectedLowerIndex: Int? = nil
    
    /// 드랍 다운 메뉴 상태
    /// [도 전채]의 드랍 상태
    @Published var isUpperDrop: Bool = false
    
    /// 드랍 다운 메뉴 상태
    /// [시/군/구 전체]의 드랍 상태
    @Published var isLowerDrop: Bool = false
    
    /// 드랍 다운 메뉴 스크롤 뷰의 초기 인덱스
    /// 선택된 인덱스를 스크롤 뷰에 바로 표시될 수 있도록함.
    @Published var upperScrollPosition: Int? = nil
    @Published var lowerScrollPosition: Int? = nil
    
    
    // MARK: - FLoating Button Properties
    
    /// 플로팅 버튼 상태
    @Published var isFloating: Bool = false
    
    
    // MARK: - Init
    
//    init(container: DIContainer){
//        self.container = container
//    }

}

extension CourseViewModel {
    
    
    /// 세그먼트 컨트롤의 값이 바뀌었을 때 호출
    /// - Parameter segment: newValue
    func segmentDidChange(to segment : CourseSegment){
        
        self.setInitialState()
        self.segment = segment
        // TODO: - 세그먼트 컨트롤 변경시 API 요청
    }
    
    /// 모든 상태를 처음 화면의 상태와 동일하게 합니다.
    func setInitialState(){
        self.resetLowerDropState()
        self.resetUpperDropState()
        self.isFloating = false
    }
    
    func resetUpperDropState(){
        self.isUpperDrop = false
        self.selectedUpperIndex = nil
        self.upperScrollPosition = nil
    }
    
    func resetLowerDropState(){
        self.isLowerDrop = false
        self.selectedLowerIndex = nil
        self.lowerScrollPosition = nil
    }
    
    /// 왼쪽 드랍 다운 메뉴의 스크롤 인덱스 값을 설정합니다.
    /// - Parameter index: 스크롤 뷰의 인덱스
    func setUpperScrollPosition(by index: Int?){
        self.upperScrollPosition = index
    }
    
    /// 오른쪽 드랍 다운 메뉴의 스크롤 인덱스 값을 설정합니다.
    /// - Parameter index: 스크롤 뷰의 인덱스
    func setLowerScrollPosition(by index: Int?){
        self.lowerScrollPosition = index
    }
    
    // TODO: - 도 전체 버튼의 들어갈 값 요청
    func requestUpperDropMenuItems(){
        
        // let response =
        // self.upperLocations = response
    }
    
    // TODO: - 도 전체 버튼에서 하나 선택하면, cd 값에 따라 시/군/구 데이터 API 요청
    // self.selectedUpperIndex에 현재 선택한 이이템의 인덱스.
    //
    func requestLowerDropMenuItems(){
        
        guard let index = self.selectedUpperIndex else { return }
        
        /// 현재 선택한 [도] 모델
        /// ex) 서울특별시, 인천광역시
        let upperLocation = self.upperLocations[index]
        
        /// 해당 데이터의 cd값.
        let cd = upperLocation.cd
        
        
        // let response =
        // self.lowerLocations = response
    }

}

final class dummyCourseViewModel{
    
    static func dummy() -> CourseViewModel{
        let viewModel = CourseViewModel()
    

        viewModel.courseList = [
            CourseResponse(
                    courseId: 1,
                    courseType: .diy,
                    courseImage: "https://i.namu.wiki/i/sopEHIQMRri9OEV0gBMh2xV0WVKv8yKvGB_-9A14bpRhRKNKJG8xCOtiN7yUuyETF52H_aKS3gTxjFHNge6yQLV5dSL8nTzGY79D8ygwut5gTvPb52s3l2a8DIKXcahnJC6RE9L_-6uL4tTCoY5W6g.webp",
                    courseName: "한강 걷기 코스한강을 따라 걷는 코스입니다.",
                    courseDescription: "한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.한강을 따라 걷는 코스입니다.",
                    categorise: [.SPORT, .BAR, .CULTURELIFE, .REST, .RESTAURANT],
                    createdDate: ""
            ),
            CourseResponse(
                courseId: 2,
                courseType: .diy,
                courseImage: "image2.jpg",
                courseName: "북촌 한옥마을 투어",
                courseDescription: "전통 한옥을 체험할 수 있는 투어입니다.",
                categorise: [.CULTURELIFE, .REST],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 3,
                courseType: .diy,
                courseImage: "image3.jpg",
                courseName: "이태원 카페 탐방",
                courseDescription: "이태원의 다양한 카페를 둘러보는 코스입니다.",
                categorise: [.CAFE, .BAR, .RESTAURANT],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 4,
                courseType: .diy,
                courseImage: "image4.jpg",
                courseName: "도심 속 힐링 코스",
                courseDescription: "도심에서 휴식을 즐길 수 있는 코스입니다.",
                categorise: [.REST, .SPORT, .EXPRERIENCE, .CULTURELIFE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 5,
                courseType: .diy,
                courseImage: "image5.jpg",
                courseName: "강릉 바다 맛집 코스",
                courseDescription: "강릉에서 맛집과 함께 바다를 즐길 수 있는 코스입니다.",
                categorise: [.RESTAURANT, .CAFE, .BAR, .EXPRERIENCE, .CULTURELIFE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 6,
                courseType: .diy,
                courseImage: "image6.jpg",
                courseName: "남산 둘레길 걷기",
                courseDescription: "남산을 둘러보는 코스입니다.",
                categorise: [.SPORT],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 7,
                courseType: .diy,
                courseImage: "image7.jpg",
                courseName: "서울 야경 투어",
                courseDescription: "서울의 야경을 즐길 수 있는 코스입니다.",
                categorise: [.CULTURELIFE, .REST],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 8,
                courseType: .diy,
                courseImage: "image8.jpg",
                courseName: "강남 맛집 투어",
                courseDescription: "강남의 숨은 맛집을 탐방하는 코스입니다.",
                categorise: [.RESTAURANT, .CAFE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 9,
                courseType: .diy,
                courseImage: "image9.jpg",
                courseName: "한강 자전거 코스",
                courseDescription: "한강을 따라 자전거를 탈 수 있는 코스입니다.",
                categorise: [.SPORT, .REST],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 10,
                courseType: .diy,
                courseImage: "image10.jpg",
                courseName: "인사동 전통 체험",
                courseDescription: "인사동에서 전통 체험을 즐길 수 있는 코스입니다.",
                categorise: [.EXPRERIENCE, .CULTURELIFE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 11,
                courseType: .diy,
                courseImage: "image11.jpg",
                courseName: "부산 해운대 힐링",
                courseDescription: "해운대에서 힐링을 즐길 수 있는 코스입니다.",
                categorise: [.REST],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 12,
                courseType: .diy,
                courseImage: "image12.jpg",
                courseName: "제주 오름 탐방",
                courseDescription: "제주의 아름다운 오름을 탐방하는 코스입니다.",
                categorise: [.SPORT, .EXPRERIENCE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 13,
                courseType: .diy,
                courseImage: "image13.jpg",
                courseName: "영화 촬영지 투어",
                courseDescription: "영화 촬영지로 유명한 곳을 방문하는 코스입니다.",
                categorise: [.CULTURELIFE, .EXPRERIENCE, .REST],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 14,
                courseType: .diy,
                courseImage: "image14.jpg",
                courseName: "산악 등반 코스",
                courseDescription: "산악을 등반하며 자연을 만끽하는 코스입니다.",
                categorise: [.SPORT],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 15,
                courseType: .diy,
                courseImage: "image15.jpg",
                courseName: "전주 한옥마을 코스",
                courseDescription: "전주의 전통 한옥마을을 탐방하는 코스입니다.",
                categorise: [.CULTURELIFE, .RESTAURANT],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 16,
                courseType: .diy,
                courseImage: "image16.jpg",
                courseName: "강원도 스키 코스",
                courseDescription: "강원도에서 스키를 즐길 수 있는 코스입니다.",
                categorise: [.SPORT, .REST],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 17,
                courseType: .diy,
                courseImage: "image17.jpg",
                courseName: "서울 마라톤 코스",
                courseDescription: "서울에서 마라톤을 경험할 수 있는 코스입니다.",
                categorise: [.SPORT, .EXPRERIENCE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 18,
                courseType: .diy,
                courseImage: "image18.jpg",
                courseName: "부산 야경 투어",
                courseDescription: "부산의 아름다운 야경을 즐기는 코스입니다.",
                categorise: [.REST, .CULTURELIFE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 19,
                courseType: .diy,
                courseImage: "image19.jpg",
                courseName: "영남 알프스 트레킹",
                courseDescription: "영남 알프스를 트레킹하며 자연을 만끽하는 코스입니다.",
                categorise: [.SPORT, .EXPRERIENCE],
                createdDate: ""
            ),
            CourseResponse(
                courseId: 20,
                courseType: .diy,
                courseImage: "image20.jpg",
                courseName: "도심 속 갤러리 투어",
                courseDescription: "도심 속 갤러리를 방문하며 예술을 감상하는 코스입니다.",
                categorise: [.CULTURELIFE],
                createdDate: ""
            )
        ]
        
        if let jsonData = jsonString_upper.data(using: .utf8) {
            do {
                let addressResponse = try JSONDecoder().decode(AddressResponse.self, from: jsonData)
                viewModel.upperLocations = addressResponse.result
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        if let jsonData = jsonString_lower.data(using: .utf8) {
            do {
                let addressResponse = try JSONDecoder().decode(AddressResponse.self, from: jsonData)
                viewModel.lowerLocations = addressResponse.result
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        return viewModel
    }
}
let jsonString_upper = """
{
    "id": "API_0701",
    "result": [
        {
            "y_coor": "1952053",
            "full_addr": "서울특별시",
            "x_coor": "953932",
            "addr_name": "서울특별시",
            "cd": "11"
        },
        {
            "y_coor": "1695144",
            "full_addr": "부산광역시",
            "x_coor": "1144829",
            "addr_name": "부산광역시",
            "cd": "21"
        },
        {
            "y_coor": "1775774",
            "full_addr": "대구광역시",
            "x_coor": "1101217",
            "addr_name": "대구광역시",
            "cd": "22"
        },
        {
            "y_coor": "1939946",
            "full_addr": "인천광역시",
            "x_coor": "929709",
            "addr_name": "인천광역시",
            "cd": "23"
        },
        {
            "y_coor": "1684701",
            "full_addr": "광주광역시",
            "x_coor": "939473",
            "addr_name": "광주광역시",
            "cd": "24"
        },
        {
            "y_coor": "1815829",
            "full_addr": "대전광역시",
            "x_coor": "990493",
            "addr_name": "대전광역시",
            "cd": "25"
        },
        {
            "y_coor": "1730025",
            "full_addr": "울산광역시",
            "x_coor": "1157564",
            "addr_name": "울산광역시",
            "cd": "26"
        },
        {
            "y_coor": "1840335",
            "full_addr": "세종특별자치시",
            "x_coor": "978417",
            "addr_name": "세종특별자치시",
            "cd": "29"
        },
        {
            "y_coor": "1920879",
            "full_addr": "경기도",
            "x_coor": "978021",
            "addr_name": "경기도",
            "cd": "31"
        },
        {
            "y_coor": "1987302",
            "full_addr": "강원특별자치도",
            "x_coor": "1059213",
            "addr_name": "강원특별자치도",
            "cd": "32"
        },
        {
            "y_coor": "1860032",
            "full_addr": "충청북도",
            "x_coor": "1003504",
            "addr_name": "충청북도",
            "cd": "33"
        },
        {
            "y_coor": "1853662",
            "full_addr": "충청남도",
            "x_coor": "930163",
            "addr_name": "충청남도",
            "cd": "34"
        },
        {
            "y_coor": "1758283",
            "full_addr": "전북특별자치도",
            "x_coor": "964651",
            "addr_name": "전북특별자치도",
            "cd": "35"
        },
        {
            "y_coor": "1647012",
            "full_addr": "전라남도",
            "x_coor": "924272",
            "addr_name": "전라남도",
            "cd": "36"
        },
        {
            "y_coor": "1830430",
            "full_addr": "경상북도",
            "x_coor": "1112095",
            "addr_name": "경상북도",
            "cd": "37"
        },
        {
            "y_coor": "1715022",
            "full_addr": "경상남도",
            "x_coor": "1060308",
            "addr_name": "경상남도",
            "cd": "38"
        },
        {
            "y_coor": "1490395",
            "full_addr": "제주특별자치도",
            "x_coor": "905503",
            "addr_name": "제주특별자치도",
            "cd": "39"
        }
    ],
    "errMsg": "Success",
    "errCd": 0,
    "trId": "=LLV_API_0701_1737563704945"
}
"""

let jsonString_lower = """
{
    "id": "API_0701",
    "result": [
        {
            "y_coor": "1944250",
            "full_addr": "서울특별시 강남구",
            "x_coor": "961366",
            "addr_name": "강남구",
            "cd": "11230"
        },
        {
            "y_coor": "1950181",
            "full_addr": "서울특별시 강동구",
            "x_coor": "968817",
            "addr_name": "강동구",
            "cd": "11250"
        },
        {
            "y_coor": "1960547",
            "full_addr": "서울특별시 강북구",
            "x_coor": "956880",
            "addr_name": "강북구",
            "cd": "11090"
        },
        {
            "y_coor": "1951538",
            "full_addr": "서울특별시 강서구",
            "x_coor": "940183",
            "addr_name": "강서구",
            "cd": "11160"
        },
        {
            "y_coor": "1941043",
            "full_addr": "서울특별시 관악구",
            "x_coor": "950955",
            "addr_name": "관악구",
            "cd": "11210"
        },
        {
            "y_coor": "1949789",
            "full_addr": "서울특별시 광진구",
            "x_coor": "963406",
            "addr_name": "광진구",
            "cd": "11050"
        },
        {
            "y_coor": "1944106",
            "full_addr": "서울특별시 구로구",
            "x_coor": "942116",
            "addr_name": "구로구",
            "cd": "11170"
        },
        {
            "y_coor": "1940318",
            "full_addr": "서울특별시 금천구",
            "x_coor": "947013",
            "addr_name": "금천구",
            "cd": "11180"
        },
        {
            "y_coor": "1961524",
            "full_addr": "서울특별시 노원구",
            "x_coor": "962515",
            "addr_name": "노원구",
            "cd": "11110"
        },
        {
            "y_coor": "1963392",
            "full_addr": "서울특별시 도봉구",
            "x_coor": "958762",
            "addr_name": "도봉구",
            "cd": "11100"
        },
        {
            "y_coor": "1953724",
            "full_addr": "서울특별시 동대문구",
            "x_coor": "960700",
            "addr_name": "동대문구",
            "cd": "11060"
        },
        {
            "y_coor": "1945542",
            "full_addr": "서울특별시 동작구",
            "x_coor": "951541",
            "addr_name": "동작구",
            "cd": "11200"
        },
        {
            "y_coor": "1951273",
            "full_addr": "서울특별시 마포구",
            "x_coor": "947740",
            "addr_name": "마포구",
            "cd": "11140"
        },
        {
            "y_coor": "1953308",
            "full_addr": "서울특별시 서대문구",
            "x_coor": "950469",
            "addr_name": "서대문구",
            "cd": "11130"
        },
        {
            "y_coor": "1941664",
            "full_addr": "서울특별시 서초구",
            "x_coor": "958560",
            "addr_name": "서초구",
            "cd": "11220"
        },
        {
            "y_coor": "1950284",
            "full_addr": "서울특별시 성동구",
            "x_coor": "959458",
            "addr_name": "성동구",
            "cd": "11040"
        },
        {
            "y_coor": "1956365",
            "full_addr": "서울특별시 성북구",
            "x_coor": "957400",
            "addr_name": "성북구",
            "cd": "11080"
        },
        {
            "y_coor": "1945217",
            "full_addr": "서울특별시 송파구",
            "x_coor": "965995",
            "addr_name": "송파구",
            "cd": "11240"
        },
        {
            "y_coor": "1947596",
            "full_addr": "서울특별시 양천구",
            "x_coor": "942501",
            "addr_name": "양천구",
            "cd": "11150"
        },
        {
            "y_coor": "1947168",
            "full_addr": "서울특별시 영등포구",
            "x_coor": "947876",
            "addr_name": "영등포구",
            "cd": "11190"
        },
        {
            "y_coor": "1948126",
            "full_addr": "서울특별시 용산구",
            "x_coor": "954044",
            "addr_name": "용산구",
            "cd": "11030"
        },
        {
            "y_coor": "1957902",
            "full_addr": "서울특별시 은평구",
            "x_coor": "949435",
            "addr_name": "은평구",
            "cd": "11120"
        },
        {
            "y_coor": "1955185",
            "full_addr": "서울특별시 종로구",
            "x_coor": "953858",
            "addr_name": "종로구",
            "cd": "11010"
        },
        {
            "y_coor": "1951313",
            "full_addr": "서울특별시 중구",
            "x_coor": "955475",
            "addr_name": "중구",
            "cd": "11020"
        },
        {
            "y_coor": "1955450",
            "full_addr": "서울특별시 중랑구",
            "x_coor": "964062",
            "addr_name": "중랑구",
            "cd": "11070"
        }
    ],
    "errMsg": "Success",
    "errCd": 0,
    "trId": "EDWI_API_0701_1737572555890"
}
"""
