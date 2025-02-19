//
//  GroupRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/13/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 관리] Repository 객체
class GroupRepository: GroupRepositoryProtocol {
    
    // MARK: - Properties
    
    let provider: GroupServiceProtocol
    
    // MARK: - Initializer
    
    init(provider: GroupServiceProtocol = GroupService()) {
        self.provider = provider
    }
    
    // MARK: - Methods
    
    func postCreateGroup(
            group: GroupInfo
        ) -> AnyPublisher<ResponseData<CreateGroupResponse>, MoyaError> {
            return provider.postCreateGroup(group: group)
        }
    
    func postGroupJoin(
        groupJoinRequest: GroupJoinRequest
    ) -> AnyPublisher<ResponseData<GroupJoinResponse>, MoyaError> {
        return provider.postGroupJoin(groupJoinRequest: groupJoinRequest)
    }
    
    func getGroupInvite(
        inviteCode: String
    ) -> AnyPublisher<ResponseData<GroupInviteResponse>, MoyaError> {
        return provider.getGroupInvite(inviteCode: inviteCode)
    }
    
    func getGroupMembers(
        groupId: Int
    ) -> AnyPublisher<ResponseData<[GroupMemberResponse]>, MoyaError> {
        return provider.getGroupMembers(groupId: groupId)
    }
    
    func getMyGroups(
        year: Int,
        month: Int
    ) -> AnyPublisher<ResponseData<[GroupCalendarResponse]>, MoyaError> {
        return provider.getMyGroups(year: year, month: month)
    }

    
    func deleteGroupLeave(
        groupId: Int
    ) -> AnyPublisher<ResponseData<GroupLeaveResponse>, MoyaError> {
        return provider.deleteGroupLeave(groupId: groupId)
    }
}
