//
//  VotingMemberUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//


import Foundation
import Combine
import CombineMoya
import Moya

/// [투표 멤버 관리] UseCaseProtocol
protocol VotingMemberUseCaseProtocol {
    
    /// 투표 멤버 조회
    func executeGetVoteMember(voteRequest: VoteRequest) -> AnyPublisher<ResponseData<VoteResponse>, MoyaError>
}
