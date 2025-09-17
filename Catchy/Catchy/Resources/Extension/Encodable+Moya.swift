//
//  Encodable+Moya.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/8/25.
//

import Foundation
import Moya

extension Encodable {
    private func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let obj = try JSONSerialization.jsonObject(with: data, options: [])
        return obj as? [String: Any] ?? [:]
    }
    
    private func asParameters() -> [String: Any] {
        (try? self.asDictionary()) ?? [:]
    }
    
    func asQueryTask() -> Moya.Task {
        .requestParameters(parameters: asParameters(), encoding: URLEncoding.queryString)
    }
}
