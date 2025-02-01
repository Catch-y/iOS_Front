//
//  GroupMembersUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 유저 조회] UseCase 객체
class GroupMembersUseCase: GroupMembersUseCaseProtocol {
    private let repository: GroupMembersRepositoryProtocol
    
    init(repository: GroupMembersRepositoryProtocol = GroupMembersRepository()) {
        self.repository = repository
    }
    
    func executeGetGroupMembers(groupMemberRequest: GroupMembersRequest) -> AnyPublisher<ResponseData<BaseResponseListGroupMemberResponse>, Error> {
        return repository.getGroupMembers(groupMemberRequest: groupMemberRequest)
    }
}
