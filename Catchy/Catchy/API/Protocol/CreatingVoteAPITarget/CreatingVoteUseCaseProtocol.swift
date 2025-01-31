//
//  CreatingVoteUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine

/// [투표 생성] UseCase Protocol
protocol CreatingVoteUseCaseProtocol {
    
    /// 투표 생성 실행
    func executePostCreateVote(request: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, Error>
}
