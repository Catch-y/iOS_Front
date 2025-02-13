//
//  GroupJoinRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 초대 코드로 가입] Repository Protocol
protocol GroupJoinRepositoryProtocol {
    func postGroupJoin(groupJoinRequest: GroupJoinRequest) -> AnyPublisher<ResponseData<BaseResponseGroupJoinResponse>, Error>
}
