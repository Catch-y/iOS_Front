//
//  VoteResultCategoryUseCase.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine

/// [투표 완료 - 카테고리 확인] UseCase 객체
class VoteResultCategoryUseCase: VoteResultCategoryUseCaseProtocol {
    
    private let repository: VoteResultCategoryRepositoryProtocol
    
    init(repository: VoteResultCategoryRepositoryProtocol = VoteResultCategoryRepository()) {
        self.repository = repository
    }
    
    /// 투표 결과 카테고리 확인
    func executeGetVoteResultCategory(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, Error> {
        return repository.getVoteResultCategory(groupId: groupId, voteId: voteId)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

