//
//  VoteInProgressServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [투표 진행 중] Service Protocol
protocol VoteInProgressServiceProtocol {
    func getVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError>
}
