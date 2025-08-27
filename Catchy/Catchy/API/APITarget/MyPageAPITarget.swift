//
//  MyPageAPITarget.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Moya
import SwiftUI

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
    
    /// 프로필 사진 변경 API
    case patchProfileImage(profileImage: UIImage)
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
            
        /// 프로필 사진 변경
        case .patchProfileImage:
            return "/member/mypage/profileImage"
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
            
        /// 프로필 사진 변경
        case .patchProfileImage:
            return .patch
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
            
        case .patchProfileImage(let image):
            var multipartData = [MultipartFormData]()
            
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                multipartData.append(MultipartFormData(provider: .data(imageData), name: "profileImage", fileName: "profileImage.jpeg", mimeType: "profileImage/jpeg"))
            }
            
            return .uploadMultipart(multipartData)
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .patchProfileImage:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
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
                    "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/7fd78244-f698-43fb-888c-15c9e0cd9aa5",
                    "courseName": "한상차림 올려라 코스",
                    "courseDescription": "한식을 제대로 즐기면서 든든하게 배를 채울 수 있는 정통 한정식 코스입니다. 전채 요리부터 메인, 후식까지 순서대로 나와서 하나하나 음미하면서 먹을 수 있습니다.",
                    "categories": ["RESTAURANT", "CAFE"]
                  },
                  {
                    "courseId": 7,
                    "courseType": "DIY",
                    "courseImage": "https://i.namu.wiki/i/jDYl3xK8uotCA3p3dD-EFufHlRJPWbYLExnhfIp5YlewDm3FO0lggA4q1xyIpWkoQl-P-NkHuSQ5ZYDzgW_6Sg.webp",
                    "courseName": "월미도 싹-다 깨부수기 코스",
                    "courseDescription": "놀이기구에서 혼을 쏙 빼고 조개구이 뜯으며 바다 감성 충전 후 루프탑 바에서 기깔나게 마무리!",
                    "categories": ["EXPERIENCE", "RESTAURANT", "BAR"]
                  },
                  {
                    "courseId": 16,
                    "courseType": "AI",
                    "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/image+(5).png",
                    "courseName": "지리산 등반 코스",
                    "courseDescription": "지리산의 숨은 매력을 따라가는 천왕봉 정복 코스! 전설의 검사가 칼을 갈았다는 칼바위에서 강인한 기운을 받고, 웅장한 천왕봉 정상에서 한반도를 품에 안은 듯한 절경을 만끽하세요! 내려오는 길엔 지리산거북이산장식당에서 든든한 한 끼로 여정을 완성하는 완벽한 모험!",
                    "categories": ["REST", "RESTAURANT"]
                  },
                  {
                    "courseId": 14,
                    "courseType": "DIY",
                    "courseImage": "https://www.bogogago.com/wp-content/uploads/2023/12/인사동_12_공공3유형.webp",
                    "courseName": "인사동 전통 문화 체험",
                    "courseDescription": "들어는 보셨나 김치 박물관? 전통차마시고 도예까지!",
                    "categories": ["CULTURELIFE", "CAFE", "EXPERIENCE"]
                  },
                  {
                    "courseId": 6,
                    "courseType": "AI",
                    "courseImage": "https://catchy-bucket.s3.ap-northeast-2.amazonaws.com/course-images/image+(4).png",
                    "courseName": "다이나믹한 놀이공원 풀코스",
                    "courseDescription": " 에버랜드에서 신나는 놀이기구를 즐긴 후, 카페에서 여유를 만끽하고, 박물관 감상후 밥까지!",
                    "categories": ["EXPERIENCE", "CAFE", "CULTURELIFE"]
                  },
                  {
                    "courseId": 11,
                    "courseType": "DIY",
                    "courseImage": "https://i.pinimg.com/474x/62/f0/32/62f0324981ee60090bd1548da1473767.jpg",
                    "courseName": "친구와 힙찔이 도전할 수 있는 코스",
                    "courseDescription": "힙한데만 찾아가는 코스 ",
                    "categories": ["CAFE", "EXPERIENCE", "BAR"]
                  },
                  {
                    "courseId": 8,
                    "courseType": "DIY",
                    "courseImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfDnd3ze146S8zAHweUxYqxiyh3MxPB3ttXg&s",
                    "courseName": "교양 한 스푼, 미식 한 입",
                    "courseDescription": "전시회에서 감성 충전하고, 북카페에서 분위기 잡고, 맛집에서 제대로 한 끼 즐기면서 하루를 꽉 채우는 코스. 교양과 미식을 동시에 맛볼 준비됐다면 따라와!",
                    "categories": ["CULTURELIFE", "CAFE", "RESTAURANT"]
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
                    "reviewCount": 11,
                    "content": [
                      {
                        "reviewId": 1,
                        "name": "서울 도심 속 문화 탐방 코스",
                        "categories": ["CULTURELIFE", "RESTAURANT", "EXPERIENCE"],
                        "comment": "서울의 역사와 문화를 한눈에 볼 수 있는 코스를 다녀왔습니다. 전통과 현대가 어우러진 모습이 인상적이었고, 맛집에서의 식사도 만족스러웠습니다. 특히 갤러리 방문은 색다른 경험이었어요. 서울의 역사를 알고 싶고 분위기 있는 곳을 가고 싶다면 이 코스 추천드려요!",
                        "reviewImages": [
                          {
                            "reviewImageId": 1,
                            "imageUrl": "https://50plus.or.kr/upload/im/2020/11/0499ad6f-17d5-4257-b16c-88c6fb0676c3.jpg"
                          },
                          {
                            "reviewImageId": 2,
                            "imageUrl": "https://50plus.or.kr/upload/im/2020/11/aa620aea-4016-4266-bfe6-588d60543bd9.jpg"
                          },
                          {
                            "reviewImageId": 3,
                            "imageUrl": "https://cdn.weeklyseoul.net/news/photo/first/201504/img_27327_1.jpg"
                          },
                          {
                            "reviewImageId": 4,
                            "imageUrl": "https://cdn.seoulcity.co.kr/news/photo/202501/451143_270806_541.jpg"
                          },
                          {
                            "reviewImageId": 5,
                            "imageUrl": "https://dimg.donga.com/wps/NEWS/IMAGE/2023/06/06/119638859.1.jpg"
                          },
                        ],
                        "rating": 5,
                        "createdDate": "2025-02-20"
                      },
                      {
                        "reviewId": 2,
                        "name": "한강 뷰 카페 투어 코스",
                        "categories": ["CAFE", "RESTAURANT"],
                        "comment": "한강을 배경으로 한 카페에서 여유로운 오후를 보냈습니다. 커피 향과 한강 야경이 어우러진 그 순간이 아직도 기억에 남는 것 같아요.",
                        "reviewImages": [
                          {
                            "reviewImageId": 2,
                            "imageUrl": "https://www.cosmopolitan.co.kr/resources_old/online/org_online_image/cp/3c6ea2df-d2ce-4289-9db4-20377a7ce233.jpg"
                          },
                          {
                            "reviewImageId": 3,
                            "imageUrl": "https://cdn.3hoursahead.com/v2/content/image-comp/ac47aafd-5c53-4a5c-aaef-2c6f44d6f396.webp"
                          }
                        ],
                        "rating": 4,
                        "createdDate": "2025-02-19"
                      },
                      {
                        "reviewId": 3,
                        "name": "감성 바와 문화의 밤 코스",
                        "categories": ["BAR", "CULTURELIFE"],
                        "comment": "분위기 좋은 바에서 한 잔의 술과 함께, 근처에서 열린 소규모 전시회를 다녀왔습니다. 음악과 조명이 어우러진 그 순간은 정말 잊지 못할 추억이 되었어요. 음악 들으면서 술 한 잔 어떠세요?",
                        "reviewImages": [
                          {
                            "reviewImageId": 4,
                            "imageUrl": "https://usvillage.co.kr/assets/img/magazine/magazine_lounge01.png"
                          },
                          {
                            "reviewImageId": 5,
                            "imageUrl": "https://lh6.googleusercontent.com/proxy/HRSBKFoKR2plRNW_5CsQEIuvP6Z4_9cI3dPfG3q1_u0cPJTEx7rIW2T8fffF18p76qlpL9s2o41LL06YXPk8oA_XWHCDaQQY"
                          },
                          {
                            "reviewImageId": 6,
                            "imageUrl": "https://img.siksinhot.com/article/1661478670394899.jpg"
                          }
                        ],
                        "rating": 5,
                        "createdDate": "2025-02-18"
                      },
                      {
                        "reviewId": 4,
                        "name": "자연과 스포츠 체험 코스",
                        "categories": ["EXPERIENCE", "SPORT"],
                        "comment": "주말에 자연 속에서 스릴 넘치는 액티비티를 경험하고 왔습니다. 강렬한 스포츠 활동과 신선한 공기로 몸과 마음이 모두 재충전되는 기분이었어요.",
                        "reviewImages": [
                          {
                            "reviewImageId": 7,
                            "imageUrl": "https://www.siminsori.com/news/photo/202207/231854_81998_810.jpg"
                          },
                          {
                            "reviewImageId": 8,
                            "imageUrl": "https://media.triple.guide/triple-cms/c_limit,f_auto,h_1024,w_1024/cc552ec0-6a73-40b2-b65d-07a0e4264c20.jpeg"
                          },
                          {
                            "reviewImageId": 9,
                            "imageUrl": "https://image.kkday.com/v2/image/get/w_960%2Cc_fit%2Cq_55%2Ct_webp/s1.kkday.com/product_263450/20241205033505_sdfc7/jpg"
                          },
                          {
                            "reviewImageId": 10,
                            "imageUrl": "https://www.japanmeetings.org/assets/images/japan-incentive/exclusive-experiences/activities-outdoors/img_MI-28_TTD1-01.jpg"
                          }
                        ],
                        "rating": 4,
                        "createdDate": "2025-02-17"
                      },
                      {
                        "reviewId": 5,
                        "name": "조용한 카페와 휴식 코스",
                        "categories": ["CAFE", "REST"],
                        "comment": "분위기 좋은 카페에서 혼자만의 시간을 보내며 여유를 찾았습니다. 간결하지만 마음을 달래주는 시간이었어요.",
                        "reviewImages": [],
                        "rating": 4,
                        "createdDate": "2025-02-16"
                      },
                      {
                        "reviewId": 6,
                        "name": "미식 경험과 문화 체험 코스",
                        "categories": ["RESTAURANT", "EXPERIENCE"],
                        "comment": "여러 음식점과 문화 공간을 방문하며 다양한 맛과 경험을 느낄 수 있었습니다. 음식의 맛과 전시의 독특함이 정말 인상 깊었어요.",
                        "reviewImages": [
                          {
                            "reviewImageId": 11,
                            "imageUrl": "https://cdn.foodnews.co.kr/news/photo/202305/102589_64664_3522.jpg"
                          }
                        ],
                        "rating": 5,
                        "createdDate": "2025-02-15"
                      },
                      {
                        "reviewId": 7,
                        "name": "도심 속 힐링과 감성 코스",
                        "categories": ["CULTURELIFE", "BAR", "REST"],
                        "comment": "분주한 도심 속에서도 잠시 멈춰 힐링할 수 있는 장소를 찾았습니다. 감각적인 인테리어와 잔잔한 음악 덕분에 마음이 편안해졌어요.",
                        "reviewImages": [
                          {
                            "reviewImageId": 12,
                            "imageUrl": "https://cdn.dailytw.kr/news/photo/202007/20858_31126_1347.jpg"
                          },
                          {
                            "reviewImageId": 13,
                            "imageUrl": "https://www.interiorbay.co.kr/design/upload_file/BD38940/252adb09fabe4d42c79506d44cac88bb_67673_1.jpg"
                          }
                        ],
                        "rating": 4,
                        "createdDate": "2025-02-14"
                      },
                      {
                        "reviewId": 8,
                        "name": "액티비티와 체험의 하루 코스",
                        "categories": ["SPORT", "EXPERIENCE"],
                        "comment": "친구들과 함께 다양한 액티비티에 도전한 하루였습니다. 힘들긴 했지만 도전의 재미와 보람을 느낄 수 있었어요. 활기찬 경험 덕분에 에너지가 충전되었습니다.",
                        "reviewImages": [
                          {
                            "reviewImageId": 14,
                            "imageUrl": "https://cdn.hankyung.com/photo/201810/AA.18101090.1.jpg"
                          },
                          {
                            "reviewImageId": 15,
                            "imageUrl": "https://res.klook.com/image/upload/q_85/c_fill,w_563/activities/calsyvk7mn8k4egtumln.jpg"
                          },
                          {
                            "reviewImageId": 16,
                            "imageUrl": "https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/STq/image/sZ9eBpfJnE6ZT0ognAYV2eylDhE.jpg"
                          }
                        ],
                        "rating": 5,
                        "createdDate": "2025-02-13"
                      },
                      {
                        "reviewId": 9,
                        "name": "맛집과 카페 탐방 코스",
                        "categories": ["RESTAURANT", "CAFE"],
                        "comment": "현지인 추천 맛집과 아기자기한 카페들을 돌아보는 코스였습니다. 음식 맛은 훌륭했고, 카페의 분위기도 매우 만족스러워서 꼭 다시 가고 싶네요!",
                        "reviewImages": [
                          {
                            "reviewImageId": 17,
                            "imageUrl": "https://static.hubzum.zumst.com/hubzum/2022/01/21/14/401dc436aa124a2cbb69849f11c79681.jpg"
                          },
                          {
                            "reviewImageId": 18,
                            "imageUrl": "https://contents-cdn.viewus.co.kr/image/2024/03/CP-2023-0058/image-2c27d56e-3ba2-4deb-afc4-23557f5eb36f.jpeg"
                          },
                          {
                            "reviewImageId": 19,
                            "imageUrl": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2c/9d/56/7c/caption.jpg?w=600&h=400&s=1"
                          },
                          {
                            "reviewImageId": 20,
                            "imageUrl": "https://www.story-w.co.kr/resource/202406/contents/84boq7he6bq8ahug.png"
                          }
                        ],
                        "rating": 4,
                        "createdDate": "2025-02-12"
                      },
                      {
                        "reviewId": 10,
                        "name": "역사와 스포츠의 만남 코스",
                        "categories": ["CULTURELIFE", "SPORT"],
                        "comment": "오랜 역사의 유적지와 현대적인 스포츠 시설이 어우러진 특별한 코스였습니다. 문화와 운동이 조화를 이루는 모습이 인상적이었고, 도전정신을 자극하는 경험이었습니다.",
                        "reviewImages": [
                          {
                            "reviewImageId": 21,
                            "imageUrl": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/53/f3/42/caption.jpg?w=500&h=500&s=1"
                          },
                          {
                            "reviewImageId": 22,
                            "imageUrl": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/d0/2c/4a/cheomseongdae-astronomical.jpg?w=500&h=500&s=1"
                          },
                          {
                            "reviewImageId": 23,
                            "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQCp_ACjieUtddzqqB4ibuTDbjV9l-hUqiPA&s"
                          },
                          {
                            "reviewImageId": 24,
                            "imageUrl": "https://blog.kakaocdn.net/dn/b4ZdYE/btsJMARE1E5/SeArK4ac7nayELTNuRpYCk/img.jpg"
                          },
                          {
                            "reviewImageId": 25,
                            "imageUrl": "https://www.hidomin.com/news/photo/200901/daegutop_749.jpg"
                          }
                        ],
                        "rating": 5,
                        "createdDate": "2025-02-11"
                      },
                      {
                        "reviewId": 11,
                        "name": "바와 체험이 어우러진 코스",
                        "categories": ["BAR", "EXPERIENCE", "REST"],
                        "comment": "친구들과 함께 찾은 이 코스는 바의 다채로운 메뉴와 색다른 체험이 인상 깊었습니다. 분위기가 좋고 서비스도 훌륭해 가격 대비 만족도가 높았어요.",
                        "reviewImages": [],
                        "rating": 4,
                        "createdDate": "2025-02-10"
                      }
                    ],
                    "last": true
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
                "reviewCount": 12,
                "content": [
                  {
                    "reviewId": 1,
                    "name": "디핀 옥수",
                    "categories": ["RESTAURANT"],
                    "comment": "정말 어렵게 예약 성공한 디핀 옥수.. 요리하는 돌아이님의 식당 한 번 가보고 싶었는데 가게 되어서 너무 좋았어요 !! 트러플 버터를 올린 빵부터 비프타르트, 파스타 까지 뭐 하나 빠짐없이 다 너무 맛있었습니다. 분위기도 좋아가지고 다음에 기회되면 또 가고 싶어요~!",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://d12zq4w4guyljn.cloudfront.net/750_750_20241213120526_photo1_f9cac38cfa9a.webp"
                      },
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://dw82ptradz9jo.cloudfront.net/daylog/631e10b07597e2539eda2011/3e8f0648-72d6-422b-810a-d170cc9213d6"
                      },
                      {
                        "reviewImageId": 3,
                        "imageUrl": "https://img.siksinhot.com/place/1634087843479051.jpeg"
                      },
                      {
                        "reviewImageId": 4,
                        "imageUrl": "https://ugc-images.catchtable.co.kr/catchtable/shopinfo/sioyxlr8pMEXxcKmlqL4q_Q/f945f1f775e246899fcd9ca04d9d13f9?details500"
                      },
                      {
                        "reviewImageId": 5,
                        "imageUrl": "https://blog.kakaocdn.net/dn/A5wbv/btsJgHRdF06/T4tIkIFypDWt5kKBOqbHX0/img.jpg"
                      },
                    ],
                    "rating": 5,
                    "visitedDate": "2025-02-15"
                  },
                  {
                    "reviewId": 2,
                    "name": "군몽",
                    "categories": ["RESTAURANT"],
                    "comment": "고기깡패님의 레스토랑입니다. 안심, 등심 중 저는 등심을 먹었는데 맛있긴 한데 다른 고기랑 그렇게 크게 다른지는 잘 모르겠습니다.. 하지만 쉬림프 파스타는 정말 맛있었어요!",
                    "reviewImages": [
                        {
                            "reviewImageId": 1,
                            "imageUrl": "https://mblogthumb-phinf.pstatic.net/MjAyMzAxMThfMTkz/MDAxNjczOTcwMzQ2NDUy.Mwv0X-bxLTEIZna8MQ5wMsAHG1zgbG_m7P02_dLHEeog.7xrSjdFt-dC5WbUHIgx0REWRRSJKZKYTP4PBC4QMN3Qg.JPEG.mung-mung-/P20230117_180207774_442E0563-9957-4F83-BED1-31B8E9D9EB72.JPG?type=w800"
                        },
                        {
                            "reviewImageId": 2,
                            "imageUrl": "https://blog.kakaocdn.net/dn/bbXzvk/btsJQUm2DmH/qNKmdSMDGhkEijyQhJfEMK/img.jpg"
                        }
                    ],
                    "rating": 3,
                    "visitedDate": "2025-02-01"
                  },
                  {
                    "reviewId": 3,
                    "name": "커피 브라운",
                    "categories": ["CAFE"],
                    "comment": "괜찮은 카페라 해서 갔는데 사람 엄청 많고 커피 맛은 맹맹하기 까지.. 옛날 감성의 인테리어는 좋지만 재방문 의사는 없습니다.",
                    "reviewImages": [],
                    "rating": 1,
                    "visitedDate": "2025-01-29"
                  },
                  {
                    "reviewId": 4,
                    "name": "아베베 베이커리",
                    "categories": ["RESTAURANT"],
                    "comment": "제주도에서 제일 추천하는 빵집 !! 엄청 유명한데 그 이유가 있습니다. 빵마다 크림이 엄청 꽉차있고 어느 빵을 고르든 정말 맛있습니다. 주차는 옆에 동문시장 주차장에 해두고 걸어서 오시면 되고 가자마자 줄이 엄청 길어서 그 앞에서 줄섰습니다. 근데 회전율이 좋아서 금방금방 빠지긴 합니다. 줄 서면서 먹을 빵을 미리 생각해두고 바로바로 고르는 게 좋을 것 같아요. 제가 추천하는 건 순수우유 크림빵! 제주도에서 맛있는 빵을 먹을 수 있어서 좋았습니다!",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdmQuPTcaG0c6ffyqwtherJuYo4oYvk2O_ag&s"
                      },
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6g4VY66p_NyV7LsbqWBUJxSAF3ORCVogNCw&s"
                      },
                      {
                        "reviewImageId": 3,
                        "imageUrl": "https://media.tel-co.net/isr/uploads/04_6e5ee82e4e.JPG?w=720"
                      },
                      {
                        "reviewImageId": 4,
                        "imageUrl": "https://cdn.st-news.co.kr/news/photo/202401/9187_27848_314.jpg"
                      }                        
                    ],
                    "rating": 5,
                    "visitedDate": "2025-01-25"
                  },
                  {
                    "reviewId": 5,
                    "name": "라프레플루트 서촌",
                    "categories": ["CAFE"],
                    "comment": "골목길 안에 위치해 있는데 너무너무 예쁜 카페입니다! 딸기 디저트들이 진짜 너무 맛있어요 ~",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://mblogthumb-phinf.pstatic.net/MjAyNDA4MDFfMjky/MDAxNzIyNTIwNDY1Mjkw.FwwHiUTvouJHj33H-G9-L_ZVLUBcSis00Y1iU_pZ_Wkg._R7-9EvVz_clz5HKi92cEamX185a3AEFWUUgo_nwYiQg.JPEG/Screenshot%EF%BC%BF20240801%EF%BC%BF224349%EF%BC%BFInstagram.jpg?type=w800"
                      }
                    ],
                    "rating": 4,
                    "visitedDate": "2025-01-15"
                  },
                  {
                    "reviewId": 6,
                    "name": "더클라임 홍대점",
                    "categories": ["SPORT"],
                    "comment": "암벽등반 처음 도전해봤는데 생각보다 엄청 힘들었어요! 하지만 직원분들이 친절하게 도와주시고 코스도 다양해서 색다른 경험이었어요. 운동 좋아하는 분들에게 추천!",
                    "reviewImages": [
            
                    ],
                    "rating": 3,
                    "visitedDate": "2025-01-13"
                  },
                  {
                    "reviewId": 7,
                    "name": "반얀 트리 클럽 앤 스파 서울",
                    "categories": ["REST"],
                    "comment": "이 호텔은 사방으로 펼쳐진 남산의 뷰를 바라보며 도심 속 럭셔리 호캉스를 즐길 수 있는 곳이에요! 차분하고 고급스러운 인테리어로 되어있어서 분위기 있고 객실은 따뜻한 온수풀이 마련되어 있어 쾌적한 휴식이 가능합니다~",
                    "reviewImages": [],
                    "rating": 4,
                    "visitedDate": "2025-01-07"
                  },
                  {
                    "reviewId": 8,
                    "name": "뚝섬 한강공원 자전거 대여소",
                    "categories": ["EXPERIENCE"],
                    "comment": "키오스크가 안 되가지고 거기 직원분께 여쭸는데 너무 불친절하고 자기도 모르겠다 이런 식으로 나와서 기분이 나빴습니다.. 다음에는 다른 곳에서 빌릴 거 같네요",
                    "reviewImages": [
                      
                    ],
                    "rating": 2,
                    "visitedDate": "2024-12-28"
                  },
                  {
                    "reviewId": 9,
                    "name": "CGV 용산아이파크몰",
                    "categories": ["CULTURELIFE"],
                    "comment": "아이맥스는 역시 용산! 스크린 크기가 정말 압도적이고 사운드도 빵빵해서 영화 몰입도가 장난 아닙니다. 좌석도 편하고 전반적으로 쾌적했어요.",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://www.sisaon.co.kr/news/photo/201707/60016_58439_1947.jpg"
                      },
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://cdnimage.dailian.co.kr/news/202312/news_1701910489_1303788_m_1.jpeg"
                      },
                      {
                        "reviewImageId": 3,
                        "imageUrl": "https://mblogthumb-phinf.pstatic.net/MjAyMTAzMDhfMTU0/MDAxNjE1MjAwOTI4NTIz.WzFGR7MIynWLFzFxPkNyS2mq9hm1aA9Lw2dZ_e3fbpIg.-xaIe06N1t7LWOYVTl9Cc3JwX5Dq-GQ-A2f-os2m-zwg.JPEG.sadalsuud14/20210113_113555.jpg?type=w800"
                      }
                    ],
                    "rating": 5,
                    "visitedDate": "2024-12-10"
                  },
                  {
                    "reviewId": 10,
                    "name": "더부스 경리단점",
                    "categories": ["BAR"],
                    "comment": "수제 맥주 좋아하시면 무조건 가야 하는 곳! 맥주 종류도 많고 안주도 맛있어서 친구랑 수다 떨며 시간 가는 줄 몰랐어요. 분위기도 좋고 직원분들도 친절해서 또 가고 싶어요.",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://mblogthumb-phinf.pstatic.net/MjAyMTA0MDVfMjU3/MDAxNjE3NjAwMjc4Nzc5.w-ELhjHOzaDzdGk9HaWod9N2pytvueUA8NE2hKiQ4-Yg.6x5vH_8dsc5x2BhLBfjf8XfCRdlqiNfMOJEFLd0MODsg.JPEG.moozorim/44_%EB%8D%94%EB%B6%80%EC%8A%A4_%282%29.jpg?type=w420"
                      },
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://img.siksinhot.com/place/1453448720519434.jpg?w=307&h=300&c=Y"
                      }
                    ],
                    "rating": 5,
                    "visitedDate": "2024-12-05"
                  },
                  {
                    "reviewId": 11,
                    "name": "몽탄",
                    "categories": ["RESTAURANT"],
                    "comment": "숙성 돼지갈비와 한우등심이 정말 맛있어요! 숯불 향이 깊게 배어 있고, 고기 질이 좋아서 입에서 살살 녹습니다. 가격대는 좀 있지만, 고기 좋아하는 분들은 꼭 가보세요!",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKgPmybPGKh6tadNg0HC5qyROX1hU_DSZcKg&s"
                      },
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://mblogthumb-phinf.pstatic.net/MjAyNDA2MDNfMjQ4/MDAxNzE3MzY2OTkyMzEx.ge00NdqziDWrsI1vqCxofguVP4ZmcJAlgGTSb0CgVYUg.l4mYe6yyAbhps_yKqixJp1LvWLXrX-zqzyah8eCeRBIg.JPEG/SE-57d5c1d8-209f-11ef-b504-3121ba821a9f.jpg?type=w800"
                      },
                      {
                        "reviewImageId": 3,
                        "imageUrl": "https://blog.kakaocdn.net/dn/yqXyK/btsHqdXdSVA/fIkK4SPIpjLKb7IPgwDQp1/img.png"
                      }
                    ],
                    "rating": 5,
                    "visitedDate": "2024-11-25"
                  },
                  {
                    "reviewId": 12,
                    "name": "서울대공원 동물원",
                    "categories": ["EXPERIENCE"],
                    "comment": "가족 나들이로 다녀왔는데 아이들이 정말 좋아했어요! 동물들도 다양하고 시설도 깔끔하게 잘 관리되어 있어요. 평일 방문을 추천합니다, 주말에는 사람이 많아요!",
                    "reviewImages": [
                      {
                        "reviewImageId": 1,
                        "imageUrl": "https://mblogthumb-phinf.pstatic.net/MjAyMDA0MTFfMjk4/MDAxNTg2NjE0NjAyMjM3.4fsRBmU9fPl5a0XX3qcbU9mYrt4k6J3VVjckwjgOvY0g.oNUo7lWoCbvTZvXDzadR62AcUYtxM_51L8JZgHvxM4Ag.JPEG.kenoop/361th_Zoo_150452_by_Biduri_kenoop.blog.me.jpg?type=w800"
                      },
                      {
                        "reviewImageId": 2,
                        "imageUrl": "https://cdn.onseoul.net/news/photo/202203/16127_15835_2144.jpg"
                      }
                    ],
                    "rating": 5,
                    "visitedDate": "2024-11-18"
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
        case .patchProfileImage:
            return """
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "id": 1,
                "profileImage": "예시 프로필 이미지 데이터 생성"
              }
            }
            """.data(using: .utf8)!
        }
    }
}
