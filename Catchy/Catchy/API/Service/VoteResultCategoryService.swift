//
//  VoteResultCategoryService.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

/// [투표 완료 - 카테고리 확인] Service 객체
class VoteResultCategoryService: VoteResultCategoryServiceProtocol {
    
    private let provider: MoyaProvider<VoteResultCategoryAPITarget>
    
    init(provider: MoyaProvider<VoteResultCategoryAPITarget> = MoyaProvider<VoteResultCategoryAPITarget>()) {
        self.provider = provider
    }
    
    /// 투표 결과 카테고리 확인
    func getVoteResultCategory(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, MoyaError> {
        return provider.requestPublisher(.getVoteResultCategory(groupId: groupId, voteId: voteId))
            .map(ResponseData<VoteResultCategoryResponse>.self)
            .eraseToAnyPublisher()
    }
}
