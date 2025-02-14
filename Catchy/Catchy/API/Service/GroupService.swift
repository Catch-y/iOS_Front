//
//  GroupService.swift
//  Catchy
//
//  Created by 임소은 on 2/13/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 관리] Service 객체
class GroupService: GroupServiceProtocol {
    
    // MARK: - Properties
    
    let provider: MoyaProvider<GroupAPITarget>
    
    // MARK: - Initializer
    
    init(provider: MoyaProvider<GroupAPITarget> = APIManager.shared.testProvider(for: GroupAPITarget.self)) {
        self.provider = provider
    }
    
    // MARK: - Methods
    
    func postCreateGroup(
        createGroup: CreateGroupRequest
    ) -> AnyPublisher<ResponseData<CreateGroupResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateGroup(createGroup: createGroup))
            .map(ResponseData<CreateGroupResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func postGroupJoin(
        groupJoinRequest: GroupJoinRequest
    ) -> AnyPublisher<ResponseData<GroupJoinResponse>, MoyaError> {
        return provider.requestPublisher(.postGroupJoin(groupJoinRequest: groupJoinRequest))
            .map(ResponseData<GroupJoinResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getGroupInvite(
        inviteCode: String
    ) -> AnyPublisher<ResponseData<GroupInviteResponse>, MoyaError> {
        return provider.requestPublisher(.getGroupInvite(inviteCode: inviteCode))
            .map(ResponseData<GroupInviteResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getGroupMembers(
        groupId: Int
    ) -> AnyPublisher<ResponseData<[GroupMemberResponse]>, MoyaError> {
        return provider.requestPublisher(.getGroupMembers(groupId: groupId))
            .map(ResponseData<[GroupMemberResponse]>.self)
            .eraseToAnyPublisher()
    }
    
    func getMyGroups(
        page: Int,
        size: Int
    ) -> AnyPublisher<ResponseData<[GroupCalendarResponse]>, MoyaError> {
        return provider.requestPublisher(.getMyGroups(page: page, size: size))
            .map(ResponseData<[GroupCalendarResponse]>.self)
            .eraseToAnyPublisher()
    }
    
    func deleteGroupLeave(
        groupId: Int
    ) -> AnyPublisher<ResponseData<GroupLeaveResponse>, MoyaError> {
        return provider.requestPublisher(.deleteGroupLeave(groupId: groupId))
            .map(ResponseData<GroupLeaveResponse>.self)
            .eraseToAnyPublisher()
    }
}
