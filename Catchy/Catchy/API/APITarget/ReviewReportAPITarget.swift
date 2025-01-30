//
//  ReviewReportAPITarget.swift
//  Catchy
//
//  Created by 권용빈 on 1/27/25.
//

import Foundation
import Moya

enum ReviewReportAPITarget {
    case postReviewReportInfo(request: PostReviewReportRequest)
}

extension ReviewReportAPITarget: APITargetType {
    
    var path: String {
        switch self {
        case .postReviewReportInfo(let request):
            return "/reviews/\(request.reviewId)/report"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReviewReportInfo:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postReviewReportInfo(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
    
    var sampleData: Data {
        let json = """
        {
          "isSuccess": true,
          "code": "string",
          "message": "string",
          "result": {
            "reviewId": 0,
            "reviewType" : "COURSE",
            "message" : "string"
          }
        }
        """
        return json.data(using: .utf8)!
    }
}
