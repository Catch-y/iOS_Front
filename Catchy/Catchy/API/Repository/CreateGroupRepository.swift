//
//  CreateGroupRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 생성] Repository 객체
class CreateGroupRepository: CreateGroupRepositoryProtocol {
    private let service: CreateGroupServiceProtocol
    
    init(service: CreateGroupServiceProtocol = CreateGroupService()) {
        self.service = service
    }
    
    func postCreateGroup(creategroup: CreateGroupRequest) -> AnyPublisher<ResponseData<CreateGroupResponse>, Error> {
        return service.postCreateGroup(creategroup: creategroup)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
