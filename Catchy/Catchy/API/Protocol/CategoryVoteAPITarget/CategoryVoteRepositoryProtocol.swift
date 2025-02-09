//
//  CategoryVoteRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

protocol CategoryVoteRepositoryProtocol {
    /// 카테고리 조회
    func getCategories(voteId: Int) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError>

    /// 선택된 카테고리 저장
    func saveCategories(groupID: Int, categories: [CategoryType]) -> AnyPublisher<Void, MoyaError>
}
