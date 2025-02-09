// CategoryVoteService.swift
// Catchy
//
// Created by 임소은 on 1/30/25.



import Foundation
import Combine
import Moya

class CategoryVoteService: CategoryVoteServiceProtocol {
    
    let provider: MoyaProvider<CategoryVoteAPITarget>
    
    init(provider: MoyaProvider<CategoryVoteAPITarget> = APIManager.shared.testProvider(for: CategoryVoteAPITarget.self)) {
        self.provider = provider
    }
    
    // 카테고리 조회
    func getCategories(voteId: Int) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return provider.requestPublisher(.getCategories(voteId: voteId))
            .map(ResponseData<VoteCategoryResponse>.self)
            .eraseToAnyPublisher()
    }
}
