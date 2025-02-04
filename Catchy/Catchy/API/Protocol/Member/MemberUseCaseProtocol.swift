//
//  MemberServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

protocol MemberUseCaseProtocol {
    func executePatchNickname(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
}
