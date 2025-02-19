//
//  GroupAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 2/13/25.
//

import Foundation
import Moya

/// [그룹 관련 API Target]
enum GroupAPITarget {
    
    /// 그룹 생성
    case postCreateGroup(group: GroupInfo)
    
    /// 그룹 초대 코드로 가입
    case postGroupJoin(groupJoinRequest: GroupJoinRequest)
    
    /// 초대 코드로 그룹 정보 조회
    case getGroupInvite(inviteCode: String)
    
    /// 그룹 멤버 조회
    case getGroupMembers(groupId: Int)
    
    /// 사용자가 속한 그룹 조회
    case getMyGroups(year: Int, month: Int)
    
    /// 그룹 탈퇴
    case deleteGroupLeave(groupId: Int)
}

extension GroupAPITarget: APITargetType {
    
    var path: String {
        switch self {
        case .postCreateGroup:
            return "/group"
        case .postGroupJoin:
            return "/group/join"
        case .getGroupInvite(let inviteCode):
            return "/group/invite/\(inviteCode)"
        case .getGroupMembers(let groupId):
            return "/group/\(groupId)/members"
        case .getMyGroups:
            return "/group/my-groups"
        case .deleteGroupLeave(let groupId):
            return "/group/\(groupId)/leave"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postCreateGroup, .postGroupJoin:
            return .post
        case .getGroupInvite, .getGroupMembers, .getMyGroups:
            return .get
        case .deleteGroupLeave:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .postCreateGroup(let group):
            return .requestJSONEncodable(group)
        case .postGroupJoin(let groupJoinRequest):
            return .requestJSONEncodable(groupJoinRequest)
        case .getGroupInvite, .getGroupMembers:
            return .requestPlain
        case .getMyGroups(let year, let month):
            return .requestParameters(parameters: ["year": year, "month": month], encoding: URLEncoding.queryString)
        case .deleteGroupLeave:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        switch self {
        case .postCreateGroup:
            return """
            {
                "isSuccess": true,
                "code": "GROUP201",
                "message": "그룹 생성 성공",
                "result": {
                    "groupId": 1,
                    "groupName": "Study Group",
                    "groupLocation": "Seoul",
                    "groupImage": "https://i.pinimg.com/736x/1a/e2/8f/1ae28fe7bd5e3211be36f7a48b976226.jpg",
                    "inviteCode": "ABC123",
                    "promiseTime": "2025-02-20T05:08:03.006Z",
                    "creatorNickname": "김캐치"
                }
            }
            """.data(using: .utf8)!

        case .postGroupJoin:
            return """
            {
                "isSuccess": true,
                "code": "GROUP200",
                "message": "그룹 가입 성공",
                "result": {
                    "success": true,
                    "message": "가입 완료"
                }
            }
            """.data(using: .utf8)!

        case .getGroupInvite:
            return """
            {
                "isSuccess": true,
                "code": "GROUP200",
                "message": "그룹 초대 정보 조회 성공",
                "result": {
                    "groupName": "샘플 그룹",
                    "groupLocation": "서울 강남구",
                    "promiseTime": "2025-02-20T12:00:00Z",  
                    "groupImage": "https://i.pinimg.com/736x/1a/e2/8f/1ae28fe7bd5e3211be36f7a48b976226.jpg"
                }
            }
            """.data(using: .utf8)!

        case .getGroupMembers:
            return """
            {
                "isSuccess": true,
                "code": "GROUP200",
                "message": "그룹 유저 조회 성공",
                "result": [
                    {
                        "memberId": 1,
                        "nickname": "avatar1",
                        "profileImage": "avatar2"
                    },
                    {
                        "memberId": 2,
                        "nickname": "avatar2",
                        "profileImage": "avatar2"
                    }
                ]
            }
            """.data(using: .utf8)!

        case .getMyGroups:
            return """
            {
                "isSuccess": true,
                "code": "GROUP200",
                "message": "사용자 그룹 조회 성공",
                "result": [
                    {
                        "groupId": 1,
                        "groupName": "Group A",
                        "promiseTime": "2025-02-01T07:20:10.360Z"
                    },
                    {
                        "groupId": 2,
                        "groupName": "Group B",
                        "promiseTime": "2025-02-01T08:20:10.360Z"
                    }
                ]
            }
            """.data(using: .utf8)!

        case .deleteGroupLeave:
            return """
            {
                "isSuccess": true,
                "code": "SUCCESS",
                "message": "그룹 탈퇴 성공",
                "result": {}
            }
            """.data(using: .utf8)!
        }
    }
}
