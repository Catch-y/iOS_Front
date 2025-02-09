//
//  CategoryVoteRepository.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

class CategoryVoteRepository: CategoryVoteRepositoryProtocol {
    private let provider: MoyaProvider<CategoryVoteAPITarget> // MoyaProvider 사용

    // Moya의 샘플 데이터를 강제로 반환하도록 설정
    init(provider: MoyaProvider<CategoryVoteAPITarget> = MoyaProvider<CategoryVoteAPITarget>(stubClosure: MoyaProvider.immediatelyStub)) {
        self.provider = provider
    }

    /// 카테고리 조회
    func getCategories(voteId: Int) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        provider.requestPublisher(.getCategories(voteId: voteId))
            .map(ResponseData<VoteCategoryResponse>.self)
            .eraseToAnyPublisher()
    }

    /// 선택된 카테고리 저장
    func saveCategories(groupID: Int, categories: [CategoryType]) -> AnyPublisher<Void, MoyaError> {
        provider.requestPublisher(.saveCategories(groupID: groupID, categories: categories))
            .map { _ in () } // 성공 시 Void 반환
            .eraseToAnyPublisher()
    }
}
