//
//  VoteAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation
import Moya

/// [투표 관련 API Target]
enum VoteAPITarget {
    
    /// 투표 생성 (POST)
    case postCreateVote(createVoteRequest: CreateVoteRequest)
    
    /// 투표 진행 중 조회 (GET)
    case getVoteInProgress(voteId: Int)
    
    /// 카테고리 투표 (POST)
    case postCategoryVote(voteId: Int, categoryVoteRequest: VoteCategoryRequest)
    
    /// 카테고리 재투표 (POST)
    case postCategoryRevote(voteId: Int, revoteRequest: VoteCategoryRequest)
    
    /// 장소 투표/취소 (PATCH)
    case patchPlaceVote(groupId: Int, voteId: Int, placeVoteRequest: PlaceVoteRequest)
    
    /// 투표 진행 중 조회 (GET)
    case getVoteStatus(voteId: Int)
    
    /// 투표 완료 - 카테고리 확인 (GET)
    case getVoteResults(groupId: Int, voteId: Int)
    
    /// 투표 진행 중인 멤버 조회 (GET)
    case getVoteMembers(groupId: Int, voteId: Int)
    
    /// 투표 완료 - 카테고리 별 장소 확인 (GET)
    case getCategoryPlaces(groupId: Int, category: String)
}

extension VoteAPITarget: APITargetType {
    
    var path: String {
        switch self {
        case .postCreateVote:
            return "/vote"
        case .getVoteInProgress(let voteId):
            return "/vote/\(voteId)/category"
        case .postCategoryVote(let voteId, _):
            return "/vote/\(voteId)/category"
        case .postCategoryRevote(let voteId, _):
            return "/vote/\(voteId)/category/revote"
        case .patchPlaceVote(let groupId, let voteId, _):
            return "/vote/\(groupId)/\(voteId)/places/vote"
        case .getVoteStatus(let voteId):
            return "/vote/\(voteId)"
        case .getVoteResults(let groupId, let voteId):
            return "/vote/\(groupId)/votes/\(voteId)/results"
        case .getVoteMembers(let groupId, let voteId):
            return "/vote/\(groupId)/votes/\(voteId)/members"
        case .getCategoryPlaces(let groupId, let category):
            return "/vote/\(groupId)/categories/\(category)/places"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postCreateVote, .postCategoryVote, .postCategoryRevote:
            return .post
        case .patchPlaceVote:
            return .patch
        case .getVoteInProgress, .getVoteStatus, .getVoteResults, .getVoteMembers, .getCategoryPlaces:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .postCreateVote(let createVoteRequest):
            return .requestJSONEncodable(createVoteRequest)
        case .postCategoryVote(_, let categoryVoteRequest):
            return .requestJSONEncodable(categoryVoteRequest)
        case .postCategoryRevote(_, let revoteRequest):
            return .requestJSONEncodable(revoteRequest)
        case .patchPlaceVote(_, _, let placeVoteRequest):
            return .requestJSONEncodable(placeVoteRequest)
        case .getVoteInProgress, .getVoteStatus, .getVoteResults, .getVoteMembers, .getCategoryPlaces:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        switch self {
        case .postCreateVote:
            return """
            {
                "isSuccess": true,
                "code": "VOTE201",
                "message": "투표 생성 성공",
                "result": {
                    "voteId": 123,
                    "groupId": 1
                }
            }
            """.data(using: .utf8)!
            
        case .getVoteInProgress:
            return """
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "voteId": 0,
                "categories": [
                  {
                    "categoryId": 0,
                    "name": "string"
                  }
                ]
              }
            }
            """.data(using: .utf8)!
            
        case .postCategoryVote:
            return """
            {
                "isSuccess": true,
                "code": "VOTE200",
                "message": "카테고리 투표 성공",
                "result": {}
            }
            """.data(using: .utf8)!
            
        case .postCategoryRevote:
            return """
            {
                "isSuccess": true,
                "code": "VOTE200",
                "message": "카테고리 재투표 성공",
                "result": {}
            }
            """.data(using: .utf8)!
            
        case .patchPlaceVote:
            return """
            {
                "isSuccess": true,
                "code": "VOTE200",
                "message": "장소 투표/취소 성공",
                "result": {}
            }
            """.data(using: .utf8)!
            
        case .getVoteStatus:
            return """
            {
                "isSuccess": true,
                "code": "VOTE200",
                "message": "투표 진행 중",
                "result": {
                    "voteId": 123,
                    "status": "진행 중",
                    "totalMembers": 4,  
                    "results": [  
                        {
                            "category": "카페",
                            "voteCount": 20,
                            "votedMembers": [
                                {
                                    "memberId": 1,
                                    "nickname": "사용자1",
                                    "profileImage": "https://i.pinimg.com/474x/e0/67/06/e06706b1cd5d92eee385e776d8d80e95.jpg"
                                },
                                {
                                    "memberId": 2,
                                    "nickname": "사용자2",
                                    "profileImage": "https://i.pinimg.com/474x/c9/f4/63/c9f463542bbd33f0aa675fb3e203c503.jpg"
                                }
                            ],
                            "rank": 1
                        },
                        {
                            "category": "음식점",
                            "voteCount": 15,
                            "votedMembers": [],
                            "rank": 2
                        },
                        {
                            "category": "바",
                            "voteCount": 10,
                            "votedMembers": [],
                            "rank": 3
                        },
                        {
                            "category": "휴식",
                            "voteCount": 5,
                            "votedMembers": [
                                { "memberId": 2,
                                    "nickname": "사용자2",
                                    "profileImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzcuyqyeHVLRqBSbkeun30Louq9iSNuV4UTQ&s"
                                }
            
            
                            ],
                            "rank": 4
                        }
                    ]
                }
            }
            """.data(using: .utf8)!

        case .getVoteResults:
            return """
            {
                "isSuccess": true,
                "code": "VOTE200",
                "message": "투표 완료 - 카테고리 확인",
                "result": {
                    "groupLocation": "서울 강남구",
                    "categories": [
                        {
                            "category": "휴식",
                            "count": 10
                        },
                        {
                            "category": "카페",
                            "count": 7
                        },
                        {
                            "category": "음식점",
                             "count": 5
                        },
                        {
                            "category": "주류",
                             "count": 4
                        },
                        {
                            "category": "문화생활",
                             "count": 3
                        }
                        
                    ]
                }
            }
            """.data(using: .utf8)!
            
        case .getVoteMembers:
            return """
            {
              "isSuccess": true,
              "code": "SUCCESS",
              "message": "투표 멤버 조회 성공",
              "result": [
                {
                  "memberId": 1,
                  "nickname": "John Doe",
                  "profileImage": "https://i.pinimg.com/736x/7c/8f/7b/7c8f7b5cc46b8ba16be0492e3f69da10.jpg",
                  "hasVoted": true
                },
                {
                  "memberId": 2,
                  "nickname": "Jane Smith",
                  "profileImage": "https://i.pinimg.com/474x/f2/8a/3b/f28a3b2afe1c6162b18ee08af55377e4.jpg",
                  "hasVoted": false
                }
              ]
            }
            
            """.data(using: .utf8)!
            
        case .getCategoryPlaces:
            return """
            {
              "isSuccess": true,
              "code": "SUCCESS",
              "message": "투표 완료 - 카테고리 별 장소 확인",
              "result": {
                "groupLocation": "서울 강남구",
                "places": [
                  {
                    "placeId": 1,
                    "placeName": "카페 베네",
                    "roadAddress": "서울 강남구 테헤란로 123",
                    "rating": 4.5,
                    "reviewCount": 10,
                    "imageUrl": "https://cdn.aitimes.com/news/photo/202012/135037_133168_497.jpg",
                    "votedMembers": [
                      {
                        "memberId": 1,
                        "nickname": "John Doe",
                        "profileImage": "https://i.pinimg.com/736x/9b/90/f9/9b90f9584979b1aed95332b1b5f084e6.jpg"
                      },
                      {
                        "memberId": 2,
                        "nickname": "Jane Smith",
                        "profileImage": "https://i.pinimg.com/736x/9b/90/f9/9b90f9584979b1aed95332b1b5f084e6.jpg"
                      }
                    ]
                  },
                  {
                    "placeId": 2,
                    "placeName": "스타벅스 강남점",
                    "roadAddress": "서울 강남구 강남대로 456",
                    "rating": 4.2,
                    "reviewCount": 20,
                    "imageUrl": "https://cdn.aitimes.com/news/photo/202012/135037_133168_497.jpg",
                    "votedMembers": []
                  }
                ]
              }
            }
            """.data(using: .utf8)!
        }
    }
}
