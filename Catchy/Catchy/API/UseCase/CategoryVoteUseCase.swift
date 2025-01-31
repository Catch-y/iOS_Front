//
//  CategoryVoteUseCase.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine

/// [카테고리 투표] UseCase 객체
class CategoryVoteUseCase: CategoryVoteUseCaseProtocol {
    
    private let repository: CategoryVoteRepositoryProtocol
    
    init(repository: CategoryVoteRepositoryProtocol = CategoryVoteRepository()) {
        self.repository = repository
    }
    
    /// 카테고리 투표 실행
    func executePostCategoryVote(categoryVote: CategoryVoteRequest) -> AnyPublisher<ResponseData<CategoryVoteResponse>, Error> {
        return repository.postCategoryVote(categoryVote: categoryVote)
            .eraseToAnyPublisher()
    }
}
