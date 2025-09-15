//
//  GroupRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/10/25.
//

import Foundation
import Moya

enum GroupRouter {
    /// 그룹 생성
    case postGenerate(group: GroupGenerateRequest)
    /// 그룹 초대 코드로 가입
    case postJoin(inviteCode: GroupJoinRequest)
    /// 그룹 유저 조회
    case getGroupMember(path: GroupMemberPath)
    /// 사용자가 속한 그룹 조회
    case getGroupList(query: GroupUserQuery)
    /// 초대 코드로 그룹 정보 조회
    case getInviteGroup(path: GroupInfoPath)
    /// 그룹 탈퇴
    case deleteGroup(path: GroupDeletePath)
}

extension GroupRouter: APITargetType {
    var path: String {
        switch self {
        case .postGenerate:
            return "/group"
        case .postJoin:
            return "/group/join"
        case .getGroupMember(let path):
            return "/group/\(path.groupId)/members"
        case .getGroupList:
            return "/group/my-groups"
        case .getInviteGroup(let path):
            return "/group/invite/\(path.inviteCode)"
        case .deleteGroup(let path):
            return "/group/\(path.groupId)/leave"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postGenerate, .postJoin:
            return .post
        case .deleteGroup:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postGenerate(let group):
            return .uploadMultipart(group.asMultipartFormData())
        case .postJoin(let inviteCode):
            return .requestJSONEncodable(inviteCode)
        case .getGroupList(let query):
            return query.asQueryTask()
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postGenerate:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
