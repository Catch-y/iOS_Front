
//
//  VoteResultCategoryRepository.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

/// [투표 완료 - 카테고리 확인] Repository 객체
class VoteResultCategoryRepository: VoteResultCategoryRepositoryProtocol {
    
    private let service: VoteResultCategoryServiceProtocol
    
    init(service: VoteResultCategoryServiceProtocol = VoteResultCategoryService()) {
        self.service = service
    }
    
    /// 투표 결과 카테고리 확인
    func getVoteResultCategory(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, MoyaError> {
        return service.getVoteResultCategory(groupId: groupId, voteId: voteId)
    }
}
