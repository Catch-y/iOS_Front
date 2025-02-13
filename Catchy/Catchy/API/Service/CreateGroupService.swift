//
//  CreateGroupService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya
import CombineMoya

/// [그룹 생성] Service 객체
class CreateGroupService: CreateGroupServiceProtocol {
    private let provider: MoyaProvider<CreateGroupAPITarget>
    
    init(provider: MoyaProvider<CreateGroupAPITarget> = MoyaProvider<CreateGroupAPITarget>()) {
        self.provider = provider
    }
    
    func postCreateGroup(creategroup: CreateGroupRequest) -> AnyPublisher<ResponseData<CreateGroupResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateGroup(creategroup: creategroup))
            .map(ResponseData<CreateGroupResponse>.self)
            .eraseToAnyPublisher()
    }
}

