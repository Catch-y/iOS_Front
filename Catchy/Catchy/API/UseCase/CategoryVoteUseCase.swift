//
//  CategoryVoteUseCase.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

/// [투표 카테고리 관리] UseCase 객체
class CategoryVoteUseCase: CategoryVoteUseCaseProtocol {
    
    private let repository: CategoryVoteRepositoryProtocol
    
    init(repository: CategoryVoteRepositoryProtocol = CategoryVoteRepository()) {
        self.repository = repository
    }

    /// 카테고리 조회
    func getCategories(voteId: Int) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return repository.getCategories(voteId: voteId)
            .mapError { $0 as MoyaError }  // MoyaError로 변환
            .eraseToAnyPublisher()
    }

    /// 선택된 카테고리 저장
    func saveCategories(groupID: Int, categories: [CategoryType]) -> AnyPublisher<Void, MoyaError> {
        return repository.saveCategories(groupID: groupID, categories: categories)
            .map { _ in () } // 성공 시 Void 반환
            .eraseToAnyPublisher()
    }
}
