
//
//  VoteResultCategoryRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine
import Moya

/// [투표 완료 - 카테고리 확인] Repository Protocol
protocol VoteResultCategoryRepositoryProtocol {
    
    /// 투표 결과 카테고리 확인
    func getVoteResultCategory(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, MoyaError>
}
