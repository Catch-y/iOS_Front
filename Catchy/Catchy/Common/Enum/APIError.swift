//
//  APIError.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation

enum APIError: LocalizedError {
    case serverError(message: String, code: String)
    case emptyResult // 빈 결과
    case decodingError // 디코딩 실패
    case unknown // 알 수 없는 오류
    
    var errorDescription: String? {
            switch self {
            case .serverError(let message, let code):
                return "Server Error (\(code)): \(message)"
            case .emptyResult:
                return "No result was returned from the server."
            case .decodingError:
                return "Failed to decode the server response."
            case .unknown:
                return "An unknown error occurred."
            }
        }
}
