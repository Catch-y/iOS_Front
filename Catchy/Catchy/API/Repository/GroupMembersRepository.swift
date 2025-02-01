//
//  GroupMembersRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 유저 조회] Repository 객체
class GroupMembersRepository: GroupMembersRepositoryProtocol {
    private let service: GroupMembersServiceProtocol
    
    init(service: GroupMembersServiceProtocol = GroupMembersService()) {
        self.service = service
    }
    
    func getGroupMembers(groupMemberRequest: GroupMembersRequest) -> AnyPublisher<ResponseData<BaseResponseListGroupMemberResponse>, Error> {
        return service.getGroupMembers(groupMemberRequest: groupMemberRequest)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
