//
//  CreatingVoteService.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [투표 생성] Service 객체
class CreatingVoteService: CreatingVoteServiceProtocol {
    
    let provider: MoyaProvider<CreatingVoteAPITarget>
    
    init(provider: MoyaProvider<CreatingVoteAPITarget> = APIManager.shared.testProvider(for: CreatingVoteAPITarget.self)) {
        self.provider = provider
    }
    
    /// 투표 생성
    func postCreateVote(createVote: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateVote(createVote: createVote))
            .map(ResponseData<CreateVoteResponse>.self)
            .eraseToAnyPublisher()
    }
}
