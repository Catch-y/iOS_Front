
//
//  VoteMemberRepository.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//


import Foundation
import Combine
import CombineMoya
import Moya

/// [투표 멤버 관리] Repository 객체
class VotingMemberRepository: VotingMemberRepositoryProtocol {


    let provider: VotingMemberService

    init(provider: VotingMemberService = VotingMemberService()){
        self.provider = provider
    }

    /// 투표 멤버 조회
    func getVoteMember(voteRequest: VoteRequest) -> AnyPublisher<ResponseData<VoteResponse>, Moya.MoyaError> {
        return provider.getVoteMember(voteRequest: voteRequest)
    }

}
