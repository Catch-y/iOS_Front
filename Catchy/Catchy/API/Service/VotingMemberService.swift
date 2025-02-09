//
//  VotingMemberService.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//


import Foundation
import Combine
import CombineMoya
import Moya

/// [코스 관리] Service 객체

class VotingMemberService: VotingMemberServiceProtocol {
    
    let provider: MoyaProvider<VotingMemberAPITarget>
    
    init(provider: MoyaProvider<VotingMemberAPITarget> = APIManager.shared.testProvider(for: VotingMemberAPITarget.self)){
        self.provider = provider
    }
    
    /// 투표멤버조회
    func getVoteMember(voteRequest: VoteRequest) -> AnyPublisher<ResponseData<VoteResponse>, MoyaError> {
        return provider.requestPublisher(.getVoteMember(vote: voteRequest))
            .map(ResponseData<VoteResponse>.self)
            .eraseToAnyPublisher()
            
    }
}
