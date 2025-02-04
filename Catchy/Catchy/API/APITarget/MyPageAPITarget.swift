//
//  MyPageAPITarget.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Moya

/// 마이페이지 APITarget
enum MyPageAPITarget {
    
    /// 프로필 조회 API
    /// HTTP 메소드 : GET
    /// API Path : /member/mypage
    case getProfile
    
    
    /// 북마크된 코스 무한 스크롤 API
    /// HTTP 메소드 : GET
    /// API Path : /mypage/bookmark
    case getBookmarkCourseList(pageSize: Int, lastCourseId: Int? = nil)
}

extension MyPageAPITarget: APITargetType {
    
    
    var path: String {
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            return "/member/mypage"
            
        /// 북마크된 코스 무한 스크롤 API
        case .getBookmarkCourseList:
            return "/mypage/bookmark"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            return .get
            
        /// 북마크된 코스 무한 스크롤 API
        case .getBookmarkCourseList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
            /// 프로필 조회 API
        case .getProfile:
            return .requestPlain
            
            /// 북마크된 코스 무한 스크롤 API
        case .getBookmarkCourseList(let pageSize, let lastCourseId):
            var parameters: [String: Any] = ["pageSize": pageSize]

            if let lastCourseId = lastCourseId { // lastCourseId가 nil이면 추가 안 함
                parameters["lastCourseId"] = lastCourseId
            }

            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    var sampleData: Data {
        
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            let json = """
            {
              "isSuccess": true,
              "code": "SUCCESS",
              "message": "요청이 성공했습니다.",
              "result": {
                "id": 1,
                "profileImage": "https://static.wanted.co.kr/images/company/21181/dazl35csneuul4f9__1080_790.jpg",
                "nickname": "용콩"
              }
            }
            """
            return json.data(using: .utf8)!
            
        
        /// 북마크된 코스 무한 스크롤 API
        case .getBookmarkCourseList:
            let json = """
            {
              "isSuccess": true,
              "code": "SUCCESS",
              "message": "요청이 성공했습니다.",
              "result": {
                "content": [
                  {
                    "courseId": 1,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/qiIgxBLKD2DisRt4lGaFOH62EFMz_L3WFF9cU4LKlqFFLuhw9vTOJBx0RqDyZgu4_evDAqgEkca9Sqhw5_oJng.webp",
                    "courseName": "서울 도심 산책 코스",
                    "courseDescription": "서울 도심에서 즐기는 자연과 역사",
                    "categories": ["카페", "음식점"]
                  },
                  {
                    "courseId": 2,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/d1A_wD4kuLHmOOFqJdVlOXVt1TWA9NfNt_HA0CS0Y_N0zayUAX8olMuv7odG2FiDLDQZIRBqbPQwBSArXfEJlQ.webp",
                    "courseName": "한강 야경 투어",
                    "courseDescription": "한강에서 야경을 즐기며 힐링하는 코스",
                    "categories": ["스포츠", "음식점"]
                  },
                  {
                    "courseId": 3,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/PagwakcE00JZaGpEvXym79-IMvKFBmdqOBlq778J-bvJMwz15lDLleTKc56S2wwcRcaEm3FZZ4EtniRa5bXdeQ.webp",
                    "courseName": "부산 바닷가 드라이브 코스",
                    "courseDescription": "부산의 해안 도로를 따라 드라이브하는 코스",
                    "categories": ["스포츠", "카페"]
                  },
                  {
                    "courseId": 4,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/IhFrc6uiSNlonNFRXzSNrKrhPKrjpmlmsB_SDg3x0PeW_L06BFuF7mOq8AcPDYjonfNpG64cQYsINU8sICeDpg.webp",
                    "courseName": "제주 올레길 걷기",
                    "courseDescription": "제주의 아름다운 자연을 만끽하는 올레길 코스",
                    "categories": ["스포츠", "체험"]
                  },
                  {
                    "courseId": 5,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/abZPxKt_L98I8ttqw56pLHtGiR5pAV4YYmpR3Ny3_n0yvff5IDoKEQFof7EbzJUSZ_-uzR5S7tzTzGQ346Qixw.webp",
                    "courseName": "강릉 바다 여행",
                    "courseDescription": "강릉의 아름다운 해변을 감상하는 여행",
                    "categories": ["카페", "휴식"]
                  },
                  {
                    "courseId": 6,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/s33TC47rcGojZ5ojPn6VONdzJqQ3qg4cpOgiuFqWZ4qnu51xoQSt9vbD2VpmDrpJi8rSifhgXD5v-JWyL7DKhA.webp",
                    "courseName": "경주 역사 탐방",
                    "courseDescription": "신라의 수도 경주에서 역사를 배우는 여행",
                    "categories": ["문화생활", "체험"]
                  },
                  {
                    "courseId": 7,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/XGgP6E-6eOwHuC84pFQpqvTvFAj1VjJQJlOOQV7Ky3MrBzI-IdXGw9r4L1YkCxUv5Uk3rYVWkmWHY8unoh8iSQ.webp",
                    "courseName": "남해 섬 투어",
                    "courseDescription": "남해의 아름다운 섬들을 탐방하는 코스",
                    "categories": ["체험", "문화생활"]
                  },
                  {
                    "courseId": 8,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/2VW6etn_MzSaFyu2KuVZx8Vgq0hxjnNL2IC4YxIBp-vx-Zn0GZ0lZWKaI8KdlzWbX2v1CRHwzZTWOQRt-mtQkw.webp",
                    "courseName": "설악산 등산 코스",
                    "courseDescription": "국립공원 설악산을 오르는 등산 코스",
                    "categories": ["스포츠", "체험"]
                  },
                  {
                    "courseId": 9,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/SvpgHv1TNHqXY_0srovmRuf9FUND_sZZxhPQpdnqB358yAIr9nTbLs3_WqgbQVjuXFhfPMoA7MgI-LKlu-PHJQ.webp",
                    "courseName": "대구 먹거리 투어",
                    "courseDescription": "대구의 유명한 음식들을 맛보는 코스",
                    "categories": ["음식점", "카페"]
                  },
                  {
                    "courseId": 10,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/Zt8NUvVHxv8RNQdIyCD06ohLHoWj5nE5hufMc55WfyOaMLdHKsjXPgP5A5ASRI-hQHLIG-O7NckxMxnckejsgQ.webp",
                    "courseName": "전주 한옥마을 여행",
                    "courseDescription": "전통 한옥과 전통 문화를 체험하는 코스",
                    "categories": ["문화생활", "체험"]
                  },
                  {
                    "courseId": 11,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/5lWzm-EzKiltQtHNvvmDZouOhbv_16dtd-A2EIbkkfcPwC6yOdqtCMaJONuqHReF5cINkERfWoR-eN0vcF0FNQ.webp",
                    "courseName": "인천 차이나타운 탐방",
                    "courseDescription": "인천 차이나타운의 매력을 탐방하는 코스",
                    "categories": ["문화생활", "음식점", "체험", "스포츠", "휴식", "카페"] 
                  }
                ],
                "isLast": true
              }
            }
            """
            return json.data(using: .utf8)!

        }
    }
}
