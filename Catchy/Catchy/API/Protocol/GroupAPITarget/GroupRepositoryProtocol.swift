//
//  GroupRepositoryProtocol.swift
//  Catchy
//
//  Created by USER on 2/13/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 관리] RepositoryProtocol
protocol GroupRepositoryProtocol {
    
    /// 그룹 생성
    /// - Parameter createGroup: 그룹 생성 요청 모델
    /// - Returns: 그룹 생성 응답 (CreateGroupResponse)
    func postCreateGroup(
        createGroup: CreateGroupRequest
    ) -> AnyPublisher<ResponseData<CreateGroupResponse>, MoyaError>
    
    
    /// 그룹 초대 코드로 가입
    /// - Parameter groupJoinRequest: 그룹 가입 요청 모델
    /// - Returns: 그룹 가입 응답 (GroupJoinResponse)
    func postGroupJoin(
        groupJoinRequest: GroupJoinRequest
    ) -> AnyPublisher<ResponseData<GroupJoinResponse>, MoyaError>
    
    
    /// 그룹 초대 코드로 그룹 정보 조회
    /// - Parameter inviteCode: 초대 코드
    /// - Returns: 그룹 정보 응답 (GroupInviteResponse)
    func getGroupInvite(
        inviteCode: String
    ) -> AnyPublisher<ResponseData<GroupInviteResponse>, MoyaError>
    
    
    /// 그룹 유저 조회
    /// - Parameter groupId: 그룹 고유 ID
    /// - Returns: 그룹 멤버 목록 응답 ([GroupMemberResponse])
    func getGroupMembers(
        groupId: Int
    ) -> AnyPublisher<ResponseData<[GroupMemberResponse]>, MoyaError>
    
    
    /// 사용자가 속한 그룹 조회
    /// - Parameters:
    ///   - page: 페이지 번호
    ///   - size: 페이지 크기
    /// - Returns: 그룹 목록 응답 ([GroupCalendarResponse])
    func getMyGroups(
        page: Int,
        size: Int
    ) -> AnyPublisher<ResponseData<[GroupCalendarResponse]>, MoyaError>
    
    
    /// 그룹 탈퇴
    /// - Parameter groupId: 그룹 고유 ID
    /// - Returns: 그룹 탈퇴 응답 (GroupLeaveResponse)
    func deleteGroupLeave(
        groupId: Int
    ) -> AnyPublisher<ResponseData<GroupLeaveResponse>, MoyaError>
}
