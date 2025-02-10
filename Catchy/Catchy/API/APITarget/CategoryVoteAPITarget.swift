//
//  CategoryVoteAPITarget.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Moya

/// [투표 카테고리 관리] API Target
enum CategoryVoteAPITarget {
    
    /// 카테고리 조회
    /// HTTP 메소드: GET
    /// API Path: /vote/{voteId}/category
    case getCategories(voteId: Int)

    /// 선택된 카테고리 저장
    /// HTTP 메소드: POST
    /// API Path: /groups/{groupID}/categories
    case saveCategories(groupID: Int, categories: [CategoryType])
}

extension CategoryVoteAPITarget: TargetType {
    
    // 기본 URL 설정 (여기서 baseURL은 실제 사용되는 URL로 변경해야 합니다)
    var baseURL: URL {
        return URL(string: "https://your.api.url")!  // 실제 baseURL로 수정
    }
    
    // API 경로 설정
    var path: String {
        switch self {
        case .getCategories:
            return "/vote/{voteId}/category"  // 경로 설정
        case .saveCategories:
            return " /groups/{groupID}/categories"  // 저장 API 경로
        }
    }
    
    // HTTP 메서드 설정
    var method: Moya.Method {
        switch self {
        case .getCategories:
            return .get  // GET 메서드 사용
        case .saveCategories:
            return .post  // POST 메서드 사용
        }
    }
    
    // 요청의 본문 설정 (파라미터가 없으면 requestPlain 사용)
    var task: Task {
        switch self {
        case .getCategories:
            return .requestPlain  // GET 요청이므로 별도의 파라미터가 없습니다.
        case .saveCategories(_, let categories):
            // 카테고리 데이터를 JSON 형태로 전달
            let categoryData = categories.map { ["id": $0.rawValue] }
            return .requestParameters(parameters: ["categories": categoryData], encoding: JSONEncoding.default)
        }
    }
    
    // 헤더 설정
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]  // 기본 JSON 헤더
    }
    
    // 샘플 데이터 (디버깅 용도)
    var sampleData: Data {
        switch self {
        case .getCategories:
            return """
            {
              "isSuccess": true,
              "code": "COMMON200",
              "message": "성공입니다.",
              "result": {
                "categories": [
                  {
                    "categoryId": 1,
                    "name": "음식점"
                  },
                  {
                    "categoryId": 2,
                    "name": "카페"
                  },
                  {
                    "categoryId": 3,
                    "name": "문화생활"
                  }
                ]
              }
            }
            """.data(using: .utf8)!
        case .saveCategories:
            return """
            {
                "isSuccess": true,
                "code": "COMMON200",
                "message": "카테고리가 성공적으로 저장되었습니다."
            }
            """.data(using: .utf8)!
        }
    }
}
