//
//  GroupLeaveUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 탈퇴] UseCase 객체
class GroupLeaveUseCase: GroupLeaveUseCaseProtocol {
    private let repository: GroupLeaveRepositoryProtocol
    
    init(repository: GroupLeaveRepositoryProtocol = GroupLeaveRepository()) {
        self.repository = repository
    }
    
    func executeDeleteGroupLeave(request: GroupLeaveRequest) -> AnyPublisher<ResponseData<GroupLeaveResponse>, Error> {
        return repository.deleteGroupLeave(groupLeaveRequest: request)
    }
}
