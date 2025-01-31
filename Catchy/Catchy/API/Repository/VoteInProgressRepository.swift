//
//  VoteInProgressRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [투표 진행 중] Repository 객체
class VoteInProgressRepository: VoteInProgressRepositoryProtocol {
    private let service: VoteInProgressServiceProtocol
    
    init(service: VoteInProgressServiceProtocol = VoteInProgressService()) {
        self.service = service
    }
    
    func getVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, Error> {
        return service.getVoteInProgress(voteId: voteId)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

