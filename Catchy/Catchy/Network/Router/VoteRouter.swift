//
//  VoteRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/5/25.
//

import Foundation
import Moya

enum VoteRouter {
    /// 투표 생성
    case postGenerate(id: VoteGenerateRquest)
    /// 투표 진행 중 - 카테고리 ID 목록 조회
    case getProgressIn(path: VoteInProgressPath)
    /// 카테고리 투표
    case postCategory(path: VoteCategoryPath, category: VoteCategoryRequest)
    /// 카테고리 재투표
    case postRevote(path: VoteCategoryPath, category: VoteCategoryRequest)
    /// 장소 투표/취소
    case patchPlace(path: VoteLocationTogglePath, id: VoteLocationToggleRequet)
    /// 투표 진행 중 - 카테고리 투표 현황 조회
    case getCategoryProgressIn(path: VoteStatusPath)
    /// 투표 완료- 카테고리 확인
    case getCompleteVote(path: VoteCompletePath)
    /// 투표 진행 중 - 멤버 별 투표 현황 조회
    case getMember(path: VoteMemeberInProgressPath)
    /// 투표 완료 - 카테고리 별 장소 확인
    case getCategroyPlace(path: VoteCategoryPlacePath, query: VoteCategoryPlaceQuery)
}

extension VoteRouter: APITargetType {
    var path: String {
        switch self {
        case .postGenerate:
            return "/vote"
        case .getProgressIn(let path):
            return "/vote/\(path.voteId)/category"
        case .postCategory(let path, _):
            return "/vote/\(path.voteId)/category"
        case .postRevote(let path, _):
            return "/vote/\(path.voteId)/category/revote"
        case .patchPlace(let path, _):
            return "/vote/\(path.groupId)/\(path.voteId)/places/vote"
        case .getCategoryProgressIn(let path):
            return "/vote/\(path.voteId)"
        case .getCompleteVote(let path):
            return "/vote/\(path.groupId)/votes/\(path.voteId)/results"
        case .getMember(let path):
            return "/vote/\(path.groupId)/votes/\(path.voteId)/results"
        case .getCategroyPlace(let path, _):
            return "/vote/\(path.groupId)/categories/\(path.category)/places"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postGenerate, .postRevote, .postCategory:
            return .post
        case .patchPlace:
            return .patch
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postGenerate(let id):
            return .requestJSONEncodable(id)
        case .postCategory(_, let category), .postRevote(_, let category):
            return .requestJSONEncodable(category)
        case .patchPlace(_, let id):
            return .requestJSONEncodable(id)
        case .getCategroyPlace(_, let query):
            return query.asQueryTask()
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
