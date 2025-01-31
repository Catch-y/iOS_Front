//
//  VoteInProgressService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [투표 진행 중] Service 객체
class VoteInProgressService: VoteInProgressServiceProtocol {
    private let provider: MoyaProvider<VoteInProgressAPITarget>
    
    init(provider: MoyaProvider<VoteInProgressAPITarget> = MoyaProvider<VoteInProgressAPITarget>()) {
        self.provider = provider
    }
    
    func getVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError> {
        return provider.requestPublisher(.getVoteInProgress(voteId: voteId))
            .map(ResponseData<VoteInProgressResponse>.self)
            .eraseToAnyPublisher()
    }
}

