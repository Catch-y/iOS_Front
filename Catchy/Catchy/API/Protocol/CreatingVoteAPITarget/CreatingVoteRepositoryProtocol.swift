//
//  CreatingVoteRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import Foundation
import Combine

/// [투표 생성] Repository Protocol
protocol CreatingVoteRepositoryProtocol {
    
    /// 투표 생성
    func postCreateVote(request: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, Error>
}

