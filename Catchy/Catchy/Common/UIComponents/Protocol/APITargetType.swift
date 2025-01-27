//
//  APITargetType.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Moya

protocol APITargetType: TargetType {}

extension APITargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("Invalid Base URL")
        }
        return url
    }
}
