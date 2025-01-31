//
//  CreatingVoteUseCase.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine

/// [투표 생성] UseCase 객체
class CreatingVoteUseCase: CreatingVoteUseCaseProtocol {
    
    private let repository: CreatingVoteRepositoryProtocol
    
    init(repository: CreatingVoteRepositoryProtocol = CreatingVoteRepository()) {
        self.repository = repository
    }
    
    /// 투표 생성 실행
    func executePostCreateVote(request: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, Error> {
        return repository.postCreateVote(request: request)
            .eraseToAnyPublisher()
    }
}

