//
//  GroupUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/13/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 관리] UseCase 객체
class GroupUseCase: GroupUseCaseProtocol {
    
    // MARK: - Properties
    
    let repository: GroupRepositoryProtocol
    
    // MARK: - Initializer
    
    init(repository: GroupRepositoryProtocol = GroupRepository()) {
        self.repository = repository
    }
    
    // MARK: - Methods
    
    func executePostCreateGroup(
            group: GroupInfo
        ) -> AnyPublisher<ResponseData<CreateGroupResponse>, MoyaError> {
            return repository.postCreateGroup(group: group)
                .mapError { $0 as MoyaError }
                .eraseToAnyPublisher()
        }
    
    func executePostGroupJoin(
        groupJoinRequest: GroupJoinRequest
    ) -> AnyPublisher<ResponseData<GroupJoinResponse>, MoyaError> {
        return repository.postGroupJoin(groupJoinRequest: groupJoinRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetGroupInvite(
        inviteCode: String
    ) -> AnyPublisher<ResponseData<GroupInviteResponse>, MoyaError> {
        return repository.getGroupInvite(inviteCode: inviteCode)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetGroupMembers(
        groupId: Int
    ) -> AnyPublisher<ResponseData<[GroupMemberResponse]>, MoyaError> {
        return repository.getGroupMembers(groupId: groupId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetMyGroups(
        page: Int,
        size: Int
    ) -> AnyPublisher<ResponseData<[GroupCalendarResponse]>, MoyaError> {
        return repository.getMyGroups(year: page, month: size)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeDeleteGroupLeave(
        groupId: Int
    ) -> AnyPublisher<ResponseData<GroupLeaveResponse>, MoyaError> {
        return repository.deleteGroupLeave(groupId: groupId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}
