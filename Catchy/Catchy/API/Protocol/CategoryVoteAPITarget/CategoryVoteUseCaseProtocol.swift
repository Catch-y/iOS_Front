
//
//  CategoryVoteUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//
// CategoryVoteUseCaseProtocol.swift

import Foundation
import Combine
import Moya

protocol CategoryVoteUseCaseProtocol {
    func getCategories(voteId: Int) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError>
}
