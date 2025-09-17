//
//  GroupUseCaseProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol GroupUseCaseProtocol {
    /// 그룹 생성
    func executePostGenerate(group: GroupGenerateRequest) -> AnyPublisher<ResponseData<GroupGenerateResponse>, MoyaError>
    /// 그룹 초대 코드로 가입
    func executePostJoin(inviteCode: GroupJoinRequest) -> AnyPublisher<ResponseData<GroupJoinResponse>, MoyaError>
    /// 그룹 유저 조회
    func executeGetGroupMember(path: GroupMemberPath) -> AnyPublisher<ResponseData<GroupMemberResponse>, MoyaError>
    /// 사용자가 속한 그룹 조회
    func executeGetGroupList(query: GroupUserQuery) -> AnyPublisher<ResponseData<GroupUserResponse>, MoyaError>
    /// 초대 코드로 그룹 정보 조회
    func executeGetInviteGroup(path: GroupInfoPath) -> AnyPublisher<ResponseData<GroupInfoResponse>, MoyaError>
    /// 그룹 탈퇴
    func executeDeleteGroup(path: GroupDeletePath) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
}
