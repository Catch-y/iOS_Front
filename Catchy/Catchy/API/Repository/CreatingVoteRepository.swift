//
//  CreatingVoteRepository.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine

/// [투표 생성] Repository 객체
class CreatingVoteRepository: CreatingVoteRepositoryProtocol {
    
    private let service: CreatingVoteServiceProtocol
    
    init(service: CreatingVoteServiceProtocol = CreatingVoteService()) {
        self.service = service
    }
    
    /// 투표 생성
    func postCreateVote(createVote: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, Error> {
        return service.postCreateVote(createVote: createVote)
            .mapError { error in
                print("❌ [CreatingVoteRepository] postCreateVote 에러 발생: \(error)")
                return error
            }
            .eraseToAnyPublisher()
    }
}

