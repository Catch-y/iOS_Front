//
//  CreateGroupUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 생성] UseCase 객체
class CreateGroupUseCase: CreateGroupUseCaseProtocol {
    private let repository: CreateGroupRepositoryProtocol
    
    init(repository: CreateGroupRepositoryProtocol = CreateGroupRepository()) {
        self.repository = repository
    }
    
    func executeCreateGroup(creategroup: CreateGroupRequest) -> AnyPublisher<ResponseData<CreateGroupResponse>, Error> {
        return repository.postCreateGroup(creategroup: creategroup)
    }
}
