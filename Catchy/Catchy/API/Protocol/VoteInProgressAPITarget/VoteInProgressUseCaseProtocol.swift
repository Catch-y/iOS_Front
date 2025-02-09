//
//  VoteInProgressUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [투표 진행 중] UseCase Protocol
protocol VoteInProgressUseCaseProtocol {
    func executeGetVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, Error>
}
