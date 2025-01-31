
//
//  CategoryVoteService.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

/// [카테고리 투표] Service 객체
class CategoryVoteService: CategoryVoteServiceProtocol {
    private let provider: MoyaProvider<CategoryVoteAPITarget>

    init(provider: MoyaProvider<CategoryVoteAPITarget> = MoyaProvider<CategoryVoteAPITarget>()) {
        self.provider = provider
    }

    /// 카테고리 투표 실행
    func postCategoryVote(categoryRequest: CategoryVoteRequest) -> AnyPublisher<ResponseData<CategoryVoteResponse>, MoyaError> {
        return provider.requestPublisher(.postCategoryVote(categoryVote: categoryRequest))
            .map(ResponseData<CategoryVoteResponse>.self)
            .eraseToAnyPublisher()
    }
}


