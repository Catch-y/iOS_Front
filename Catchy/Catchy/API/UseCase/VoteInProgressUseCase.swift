//
//  VoteInProgressUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [투표 진행 중] UseCase 객체
class VoteInProgressUseCase: VoteInProgressUseCaseProtocol {
    private let repository: VoteInProgressRepositoryProtocol
    
    init(repository: VoteInProgressRepositoryProtocol = VoteInProgressRepository()) {
        self.repository = repository
    }
    
    func executeGetVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, Error> {
        return repository.getVoteInProgress(voteId: voteId)
    }
}
