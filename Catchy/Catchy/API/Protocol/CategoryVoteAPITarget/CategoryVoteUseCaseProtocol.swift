
//
//  CategoryVoteUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

/// [카테고리 투표] UseCase Protocol
protocol CategoryVoteUseCaseProtocol {
    func executePostCategoryVote(categoryRequest: CategoryVoteRequest) -> AnyPublisher<ResponseData<CategoryVoteResponse>, MoyaError>
}
