//
//  CreateGroupServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [그룹 생성] Service Protocol
protocol CreateGroupServiceProtocol {
    func postCreateGroup(creategroup: CreateGroupRequest) -> AnyPublisher<ResponseData<CreateGroupResponse>, MoyaError>
}
