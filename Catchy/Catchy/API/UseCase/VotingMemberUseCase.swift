//
//  VotingMemberUseCase.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [투표멤버 관리] UseCase 객체
class VotingMemberUseCase: VotingMemberUseCaseProtocol {
    
    let repository: VotingMemberRepositoryProtocol
    
    init(repository: VotingMemberRepositoryProtocol = VotingMemberRepository()) {
        self.repository = repository
    }
    
    /// 코스 조회
    func executeGetVoteMember(voteRequest: VoteRequest) -> AnyPublisher<ResponseData<VoteResponse>, MoyaError> {
        
        return repository.getVoteMember(voteRequest: voteRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}



