//
//  GroupJoinServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [그룹 초대 코드로 가입] Service Protocol
protocol GroupJoinServiceProtocol {
    func postGroupJoin(groupJoinRequest: GroupJoinRequest) -> AnyPublisher<ResponseData<BaseResponseGroupJoinResponse>, MoyaError>
}
