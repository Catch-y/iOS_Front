//
//  APIError.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation

enum APIError: LocalizedError {
    case serverError(message: String, code: String)
    case emptyResult
    case decodingError(underlying: Error?)
    case unknown(underlying: Error?)
    
    var errorDescription: String? {
        switch self {
        case .serverError(let message, let code):
            return "[\(code)] \(message)"
        case .emptyResult:
            return "서버로부터 결과가 비어 있습니다."
        case .decodingError(let error):
            return "디코딩 실패: \(error?.localizedDescription ?? "Unknown decoding error")"
        case .unknown(let error):
            return "알 수 없는 오류: \(error?.localizedDescription ?? "No details")"
        }
    }
    
    var code: String? {
        if case let .serverError(_, code) = self {
            return code
        }
        return nil
    }

    var message: String? {
        if case let .serverError(message, _) = self {
            return message
        }
        return nil
    }
}
