//
//  CreatingVoteServiceProtocol.swift
//  Catchy
//

import Foundation
import Combine
import Moya

/// [투표 생성] Service Protocol
protocol CreatingVoteServiceProtocol {
    func postCreateVote(createVote: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, MoyaError>
}

