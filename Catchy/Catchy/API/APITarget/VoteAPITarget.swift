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
                "code": "VOTE200",
                "message": "투표 진행 중",
                "result": {
                    "voteId": 123,
                    "category": "음식"
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
                    "status": "진행 중"
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
                  "profileImage": "avatar1",
                  "hasVoted": true
                },
                {
                  "memberId": 2,
                  "nickname": "Jane Smith",
                  "profileImage": "avatar2",
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
                    "imageUrl": "starbucksImage",
                    "votedMembers": [
                      {
                        "memberId": 1,
                        "nickname": "John Doe",
                        "profileImage": "avatar1"
                      },
                      {
                        "memberId": 2,
                        "nickname": "Jane Smith",
                        "profileImage": "avatar2"
                      }
                    ]
                  },
                  {
                    "placeId": 2,
                    "placeName": "스타벅스 강남점",
                    "roadAddress": "서울 강남구 강남대로 456",
                    "rating": 4.2,
                    "reviewCount": 20,
                    "imageUrl": "starbucksImage",
                    "votedMembers": []
                  }
                ]
              }
            }
            """.data(using: .utf8)!
        }
    }
}
