//
//  GroupLeaveRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 탈퇴] Repository 객체
class GroupLeaveRepository: GroupLeaveRepositoryProtocol {
    private let service: GroupLeaveServiceProtocol
    
    init(service: GroupLeaveServiceProtocol = GroupLeaveService()) {
        self.service = service
    }
    
    func deleteGroupLeave(groupLeaveRequest: GroupLeaveRequest) -> AnyPublisher<ResponseData<GroupLeaveResponse>, Error> {
        return service.deleteGroupLeave(groupLeaveRequest: groupLeaveRequest)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
