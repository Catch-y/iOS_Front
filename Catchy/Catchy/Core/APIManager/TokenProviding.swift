//
//  TokenProviding.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
