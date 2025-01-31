//
//  VoteResultCategoryUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine

/// [투표 완료 - 카테고리 확인] UseCase Protocol
protocol VoteResultCategoryUseCaseProtocol {
    
    /// 투표 결과 카테고리 확인
    func executeGetVoteResultCategory(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, Error>
}

