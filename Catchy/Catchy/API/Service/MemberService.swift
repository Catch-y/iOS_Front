//
//  MemberService.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya
import Combine

class MemberService: MemberServiceProtocol {
    private let provider: MoyaProvider<MemeberAPITarget>
    
    init(provider: MoyaProvider<MemeberAPITarget> = APIManager.shared.testProvider(for: MemeberAPITarget.self)) {
        self.provider = provider
    }
    
    func patchNickname(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError> {
        return provider.requestPublisher(.patchNickname(nickname: nickname))
            .map(ResponseData<EmptyResponse>.self)
            .eraseToAnyPublisher()
    }
}
