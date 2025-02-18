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
    
    /// 내 코스 리뷰 조회 API
    /// HTTP 메소드 : GET
    /// API Path : /mypage/courseReviews
    case getMyCourseReviews(review: MyCourseReviewRequest)
    
    /// 내 장소 리뷰 조회 API
    /// HTTP 메소드 : GET
    /// API Path : /mypage/placeReviews
    case getMyPlaceReviews(review: MyPlaceReviewRequest)
    
    /// 리뷰 삭제 API
    /// HTTP 메소드 : DELETE
    /// API Path :
    case deleteReview(reviewId: Int, reviewType: ReviewType)
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
            
        /// 내 코스 리뷰 조회 API
        case .getMyCourseReviews:
            return "/mypage/courseReviews"
            
        /// 내 장소 리뷰 조회 API
        case .getMyPlaceReviews:
            return "/mypage/placeReviews"
    
        /// 리뷰 삭제 API
        case .deleteReview(let reviewId, _):
            return "/mypage/reviews/\(reviewId)"
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
            
        /// 내 코스 리뷰 조회 API
        case .getMyCourseReviews:
            return .get
            
        /// 내 장소 리뷰 조회 API
        case .getMyPlaceReviews:
            return .get
            
        /// 리뷰 삭제 API
        case .deleteReview:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
            
        /// 프로필 조회 API
        case .getProfile:
            return .requestPlain
            
        /// 북마크된 코스 무한 스크롤 API
        case .getBookmarkCourseList(_, let lastCourseId):
            var parameters: [String: Any] = ["pageSize": 10]
            
            if let lastCourseId = lastCourseId { /* lastCourseId가 nil이면 추가 안 함 */
                parameters["lastCourseId"] = lastCourseId
            }
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        /// 내 코스 리뷰 조회 API
        case .getMyCourseReviews(let review):
            var parameters: [String: Any] = ["pageSize": 10]
            if let lastReviewId = review.lastReviewId {
                parameters["lastReviewId"] = lastReviewId
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        /// 내 장소 리뷰 조회 API
        case .getMyPlaceReviews(let review):
            var parameters: [String: Any] = ["pageSize": 10]
            if let lastPlaceReviewDate = review.lastPlaceReviewDate {
                parameters["lastPlaceReviewDate"] = lastPlaceReviewDate
            }
            if let lastReviewId = review.lastReviewId {
                parameters["lastReviewId"] = lastReviewId
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        
        case .deleteReview(_, let reviewType):
            return .requestParameters(parameters: ["reviewType": reviewType.rawValue], encoding: URLEncoding.default)
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
                    "categories": ["CAFE", "BAR"]
                  },
                  {
                    "courseId": 2,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/d1A_wD4kuLHmOOFqJdVlOXVt1TWA9NfNt_HA0CS0Y_N0zayUAX8olMuv7odG2FiDLDQZIRBqbPQwBSArXfEJlQ.webp",
                    "courseName": "한강 야경 투어",
                    "courseDescription": "한강에서 야경을 즐기며 힐링하는 코스",
                    "categories": ["SPORT", "RESTAURANT"]
                  },
                  {
                    "courseId": 3,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/PagwakcE00JZaGpEvXym79-IMvKFBmdqOBlq778J-bvJMwz15lDLleTKc56S2wwcRcaEm3FZZ4EtniRa5bXdeQ.webp",
                    "courseName": "부산 바닷가 드라이브 코스",
                    "courseDescription": "부산의 해안 도로를 따라 드라이브하는 코스",
                    "categories": ["SPORT", "CAFE"]
                  },
                  {
                    "courseId": 4,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/IhFrc6uiSNlonNFRXzSNrKrhPKrjpmlmsB_SDg3x0PeW_L06BFuF7mOq8AcPDYjonfNpG64cQYsINU8sICeDpg.webp",
                    "courseName": "제주 올레길 걷기",
                    "courseDescription": "제주의 아름다운 자연을 만끽하는 올레길 코스",
                    "categories": ["SPORT", "EXPERIENCE"]
                  },
                  {
                    "courseId": 5,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/abZPxKt_L98I8ttqw56pLHtGiR5pAV4YYmpR3Ny3_n0yvff5IDoKEQFof7EbzJUSZ_-uzR5S7tzTzGQ346Qixw.webp",
                    "courseName": "강릉 바다 여행",
                    "courseDescription": "강릉의 아름다운 해변을 감상하는 여행",
                    "categories": ["CAFE", "REST"]
                  },
                  {
                    "courseId": 6,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/s33TC47rcGojZ5ojPn6VONdzJqQ3qg4cpOgiuFqWZ4qnu51xoQSt9vbD2VpmDrpJi8rSifhgXD5v-JWyL7DKhA.webp",
                    "courseName": "경주 역사 탐방",
                    "courseDescription": "신라의 수도 경주에서 역사를 배우는 여행",
                    "categories": ["CULTURELIFE", "EXPERIENCE"]
                  },
                  {
                    "courseId": 7,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/XGgP6E-6eOwHuC84pFQpqvTvFAj1VjJQJlOOQV7Ky3MrBzI-IdXGw9r4L1YkCxUv5Uk3rYVWkmWHY8unoh8iSQ.webp",
                    "courseName": "남해 섬 투어",
                    "courseDescription": "남해의 아름다운 섬들을 탐방하는 코스",
                    "categories": ["EXPERIENCE", "CULTURELIFE"]
                  },
                  {
                    "courseId": 8,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/2VW6etn_MzSaFyu2KuVZx8Vgq0hxjnNL2IC4YxIBp-vx-Zn0GZ0lZWKaI8KdlzWbX2v1CRHwzZTWOQRt-mtQkw.webp",
                    "courseName": "설악산 등산 코스",
                    "courseDescription": "국립공원 설악산을 오르는 등산 코스",
                    "categories": ["SPORT", "EXPERIENCE"]
                  },
                  {
                    "courseId": 9,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/SvpgHv1TNHqXY_0srovmRuf9FUND_sZZxhPQpdnqB358yAIr9nTbLs3_WqgbQVjuXFhfPMoA7MgI-LKlu-PHJQ.webp",
                    "courseName": "대구 먹거리 투어",
                    "courseDescription": "대구의 유명한 음식들을 맛보는 코스",
                    "categories": ["RESTAURANT", "CAFE"]
                  },
                  {
                    "courseId": 10,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/Zt8NUvVHxv8RNQdIyCD06ohLHoWj5nE5hufMc55WfyOaMLdHKsjXPgP5A5ASRI-hQHLIG-O7NckxMxnckejsgQ.webp",
                    "courseName": "전주 한옥마을 여행",
                    "courseDescription": "전통 한옥과 전통 문화를 체험하는 코스",
                    "categories": ["CULTURELIFE", "EXPERIENCE"]
                  },
                  {
                    "courseId": 11,
                    "courseType": "AI",
                    "courseImage": "https://i.namu.wiki/i/5lWzm-EzKiltQtHNvvmDZouOhbv_16dtd-A2EIbkkfcPwC6yOdqtCMaJONuqHReF5cINkERfWoR-eN0vcF0FNQ.webp",
                    "courseName": "인천 차이나타운 탐방",
                    "courseDescription": "인천 차이나타운의 매력을 탐방하는 코스",
                    "categories": ["CULTURELIFE", "RESTAURANT", "EXPERIENCE", "SPORT", "REST", "CAFE"] 
                  }
                ],
                "isLast": true
              }
            }
            """
            return json.data(using: .utf8)!
        
        /// 내 코스 리뷰 조회 API
        case .getMyCourseReviews:
            let json = """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "성공입니다.",
              "result": {
                "reviewType": "COURSE",
                "reviewCount": 6,
                "content": [
                  {
                    "reviewId": 1,
                    "name": "스타벅스 강남점스타벅스 강남점스타벅스 강남점",
                    "categories": ["CAFE", "SPORT", "REST", "RESTAURANT", "CULTURELIFE"],
                    "comment": "커피가 맛있고 분위기가 좋았어요.",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://i.namu.wiki/i/PgSYmu9y55E5YicKvIK14P0ttQUQG4ioSn-Fd6u27a0r2Jeu02fJAYRkmf2qtOb6fHLBnlrLeXu_gSESQbmykg.webp"
                      }
                    ],
                    "rating": 2,
                    "createdDate": "2019-01-15"
                  },
                  {
                    "reviewId": 2,
                    "name": "이디야 홍대점",
                    "categories": ["CAFE", "REST", "SPORT"],
                    "comment": "공간이 넓어서 공부하기 좋아요.",
                    "reviewImages": [],
                    "rating": 3,
                    "createdDate": "2024-11-10"
                  },
                  {
                    "reviewId": 3,
                    "name": "투썸플레이스 신촌점",
                    "categories": ["CAFE", "REST", "SPORT"],
                    "comment": "디저트가 정말 맛있고 커피도 좋았어요! 디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!",
                    "reviewImages": [
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://i.namu.wiki/i/PgSYmu9y55E5YicKvIK14P0ttQUQG4ioSn-Fd6u27a0r2Jeu02fJAYRkmf2qtOb6fHLBnlrLeXu_gSESQbmykg.webp"
                      },
                      {
                        "reviewImageId": 3,
                        "imageUrl": "https://i.namu.wiki/i/cBYgI4eW55VuQRpia9qaJZAw0W1PzVnrCI2x76t_z5BzSEch6Nyylw27FkJ0IJxCy8N8jGIWJwLjY9ntW3-tEg.webp"
                      },
                      {
                        "reviewImageId": 4,
                        "imageUrl": "https://i.namu.wiki/i/cBYgI4eW55VuQRpia9qaJZAw0W1PzVnrCI2x76t_z5BzSEch6Nyylw27FkJ0IJxCy8N8jGIWJwLjY9ntW3-tEg.webp"
                      },
                      {
                        "reviewImageId": 5,
                        "imageUrl": "https://i.namu.wiki/i/cBYgI4eW55VuQRpia9qaJZAw0W1PzVnrCI2x76t_z5BzSEch6Nyylw27FkJ0IJxCy8N8jGIWJwLjY9ntW3-tEg.webp"
                      },
                      {
                        "reviewImageId": 12,
                        "imageUrl": "https://i.namu.wiki/i/cBYgI4eW55VuQRpia9qaJZAw0W1PzVnrCI2x76t_z5BzSEch6Nyylw27FkJ0IJxCy8N8jGIWJwLjY9ntW3-tEg.webp"
                      }                        
                    ],
                    "rating": 1,
                    "createdDate": "2025-05-17"
                  },
                  {
                    "reviewId": 4,
                    "name": "할리스커피 건대점",
                    "categories": ["CAFE", "REST", "SPORT"],
                    "comment": "조용하고 좌석이 많아서 편했어요.",
                    "reviewImages": [],
                    "rating": 1,
                    "createdDate": "2025-05-17"
                  },
                  {
                    "reviewId": 5,
                    "name": "폴 바셋 여의도점",
                    "categories": ["RESTAURANT"],
                    "comment": "커피가 진하고 맛있어요. 인테리어도 좋습니다.",
                    "reviewImages": [
                      {
                        "reviewImageId": 4,
                        "imageUrl": "https://i.namu.wiki/i/fbGYilZ5x0mbpsAZx-5HW0lzv8cmemc7MeW8w9R7DCXT8tXT5XrdxzTUPv0rgRvRQbpzohcVjTE0tZFo28iPow.webp"
                      }
                    ],
                    "rating": 1,
                    "createdDate": "2025-02-11"
                  },
                  {
                    "reviewId": 6,
                    "name": "탐앤탐스 서울대입구점",
                    "categories": ["CAFE", "REST", "SPORT"],
                    "comment": "브라우니가 정말 맛있어요. 또 방문하고 싶습니다.",
                    "reviewImages": [
                      {
                        "reviewImageId": 5,
                        "imageUrl": "https://i.namu.wiki/i/e1SYV7mNPmWJ_7glULUwzjQKakofQIzay4bxE3o0hQPMHYWJ_mhM-oOigdsdn_ANLXD5CPmFpNfwrEFNqUIYhg.svg"
                      },
                      {
                        "reviewImageId": 6,
                        "imageUrl": "https://i.namu.wiki/i/ApmCe1wGlZ4TxBoQ141SJZMrMTbnaCDRXkncjwl-2h8a3-nWecUBT0N_A4XdFuOJgMP0jgsrrAq088K57t1Hpw.svg"
                      }
                    ],
                    "rating": 5,
                    "createdDate": "2025-01-10"
                  }
                ],
                "last": false
              }
            }
            
            """
            return json.data(using: .utf8)!
        
        /// 내 장소 리뷰 조회 API
        case .getMyPlaceReviews:
            let json = """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "성공입니다.",
              "result": {
                "reviewType": "PLACE",
                "reviewCount": 6,
                "content": [
                  {
                    "reviewId": 1,
                    "name": "맥도날드",
                    "categories": ["RESTAURANT"],
                    "comment": "햄버거 너무 맛있어요 햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요햄버거 너무 맛있어요.",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://i.namu.wiki/i/pYdtlj-fQNTInL7V6QVzRNAB_9Ip74fCiowUbuIEb03dzfy9olYTgA6-SLOD4GRe-Uub5_zWT-hocLHOcJDBxw.svg"
                      }
                    ],
                    "rating": 5,
                    "visitedDate": "2025-02-01"
                  },
                  {
                    "reviewId": 2,
                    "name": "롯데리아",
                    "categories": ["RESTAURANT"],
                    "comment": "공간이 넓어서 공부하기 좋아요.",
                    "reviewImages": [],
                    "rating": 4,
                    "visitedDate": "2025-01-25"
                  },
                  {
                    "reviewId": 3,
                    "name": "버거킹 버거킹",
                    "categories": ["RESTAURANT"],
                    "comment": "디저트가 정말 맛있고 커피도 좋았어요! 디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!디저트가 정말 맛있고 커피도 좋았어요!",
                    "reviewImages": [
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://i.namu.wiki/i/5IrysxQnQyGWVrB0OSXZE4fjmB1kizS-hg0tTaMAaKG_4ZnMdv_glXV31cpWgeZ2VHyF152gkOWJkoNf5Ge8lg.svg"
                      },
                      {
                        "reviewImageId": 3,
                        "imageUrl": "https://i.namu.wiki/i/5IrysxQnQyGWVrB0OSXZE4fjmB1kizS-hg0tTaMAaKG_4ZnMdv_glXV31cpWgeZ2VHyF152gkOWJkoNf5Ge8lg.svg"
                      },
                      {
                        "reviewImageId": 4,
                        "imageUrl": "https://i.namu.wiki/i/5IrysxQnQyGWVrB0OSXZE4fjmB1kizS-hg0tTaMAaKG_4ZnMdv_glXV31cpWgeZ2VHyF152gkOWJkoNf5Ge8lg.svg"
                      },
                      {
                        "reviewImageId": 5,
                        "imageUrl": "https://i.namu.wiki/i/cBYgI4eW55VuQRpia9qaJZAw0W1PzVnrCI2x76t_z5BzSEch6Nyylw27FkJ0IJxCy8N8jGIWJwLjY9ntW3-tEg.webp"
                      },
                      {
                        "reviewImageId": 12,
                        "imageUrl": "https://i.namu.wiki/i/5IrysxQnQyGWVrB0OSXZE4fjmB1kizS-hg0tTaMAaKG_4ZnMdv_glXV31cpWgeZ2VHyF152gkOWJkoNf5Ge8lg.svg"
                      }                        
                    ],
                    "rating": 5,
                    "visitedDate": "2025-01-20"
                  },
                  {
                    "reviewId": 4,
                    "name": "할리스커피 건대점",
                    "categories": ["RESTAURANT"],
                    "comment": "조용하고 좌석이 많아서 편했어요.",
                    "reviewImages": [],
                    "rating": 3,
                    "visitedDate": "2025-01-18"
                  },
                  {
                    "reviewId": 5,
                    "name": "폴 바셋 여의도점",
                    "categories": ["RESTAURANT"],
                    "comment": "커피가 진하고 맛있어요. 인테리어도 좋습니다.",
                    "reviewImages": [
                      {
                        "reviewImageId": 4,
                        "imageUrl": "https://i.namu.wiki/i/fbGYilZ5x0mbpsAZx-5HW0lzv8cmemc7MeW8w9R7DCXT8tXT5XrdxzTUPv0rgRvRQbpzohcVjTE0tZFo28iPow.webp"
                      }
                    ],
                    "rating": 4,
                    "visitedDate": "2025-01-15"
                  },
                  {
                    "reviewId": 6,
                    "name": "탐앤탐스 서울대입구점",
                    "categories": ["RESTAURANT"],
                    "comment": "브라우니가 정말 맛있어요. 또 방문하고 싶습니다.",
                    "reviewImages": [
                      {
                        "reviewImageId": 5,
                        "imageUrl": "https://i.namu.wiki/i/e1SYV7mNPmWJ_7glULUwzjQKakofQIzay4bxE3o0hQPMHYWJ_mhM-oOigdsdn_ANLXD5CPmFpNfwrEFNqUIYhg.svg"
                      },
                      {
                        "reviewImageId": 6,
                        "imageUrl": "https://i.namu.wiki/i/ApmCe1wGlZ4TxBoQ141SJZMrMTbnaCDRXkncjwl-2h8a3-nWecUBT0N_A4XdFuOJgMP0jgsrrAq088K57t1Hpw.svg"
                      }
                    ],
                    "rating": 5,
                    "visitedDate": "2025-01-10"
                  }
                ],
                "last": true
              }
            }
            
            """
            return json.data(using: .utf8)!
            
        case .deleteReview:
            let json = """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "성공입니다.",
              "result": {
                "reviewId": 1,
                "reviewType": "COURSE",
                "message": "리뷰 삭제"
              }
            }
            
            """
            return json.data(using: .utf8)!
        }
    }
}
