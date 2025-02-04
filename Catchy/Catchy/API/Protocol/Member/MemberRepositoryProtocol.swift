//
//  MemberServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya
import Combine

protocol MemberRepositoryProtocol {
    func patchNicknameData(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
}
