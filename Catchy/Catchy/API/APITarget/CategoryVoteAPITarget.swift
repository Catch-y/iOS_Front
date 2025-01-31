//
//  CategoryVoteAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Moya

/// [카테고리 투표] API Target
enum CategoryVoteAPITarget {
    
    /// 카테고리 투표
    /// HTTP 메소드 : POST
    /// API Path : /vote/category
    case postCategoryVote(categoryVote: CategoryVoteRequest) 
}

extension CategoryVoteAPITarget: APITargetType {
    
    var path: String {
        switch self {
        case .postCategoryVote:
            return "/vote/category"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postCategoryVote:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postCategoryVote(let request):
            return .requestJSONEncodable(request)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        let jsonString = """
        {
            "isSuccess": true,
            "code": "VOTE200",
            "message": "카테고리 투표가 성공적으로 완료되었습니다.",
            "result": {
                "success": true
            }
        }
        """.data(using: .utf8)!
        return jsonString
    }
}

