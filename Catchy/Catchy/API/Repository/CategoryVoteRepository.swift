

//
//  CategoryVoteRepository.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

/// [카테고리 투표] Repository 객체
class CategoryVoteRepository: CategoryVoteRepositoryProtocol {
    private let service: CategoryVoteServiceProtocol

    init(service: CategoryVoteServiceProtocol = CategoryVoteService()) {
        self.service = service
    }

    /// 카테고리 투표 실행
    func postCategoryVote(categoryRequest: CategoryVoteRequest) -> AnyPublisher<ResponseData<CategoryVoteResponse>, MoyaError> {
        return service.postCategoryVote(categoryRequest: categoryRequest)
    }
}
