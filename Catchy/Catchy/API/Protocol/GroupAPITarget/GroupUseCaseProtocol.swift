//
//  GroupUseCaseProtocol.swift
//  Catchy
//
//  Created by USER on 2/13/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 관리] UseCaseProtocol
protocol GroupUseCaseProtocol {
    
    /// 그룹 생성
    func executePostCreateGroup(
        group: GroupInfo
    ) -> AnyPublisher<ResponseData<CreateGroupResponse>, MoyaError>

    
    /// 그룹 초대 코드로 가입
    func executePostGroupJoin(
        groupJoinRequest: GroupJoinRequest
    ) -> AnyPublisher<ResponseData<GroupJoinResponse>, MoyaError>
    
    /// 그룹 초대 코드로 그룹 정보 조회
    func executeGetGroupInvite(
        inviteCode: String
    ) -> AnyPublisher<ResponseData<GroupInviteResponse>, MoyaError>
    
    /// 그룹 유저 조회
    func executeGetGroupMembers(
        groupId: Int
    ) -> AnyPublisher<ResponseData<[GroupMemberResponse]>, MoyaError>
    
    /// 사용자가 속한 그룹 조회
    func executeGetMyGroups(
        page: Int,
        size: Int
    ) -> AnyPublisher<ResponseData<[GroupCalendarResponse]>, MoyaError>
    
    /// 그룹 탈퇴
    func executeDeleteGroupLeave(
        groupId: Int
    ) -> AnyPublisher<ResponseData<GroupLeaveResponse>, MoyaError>
}
