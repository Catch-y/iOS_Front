//
//  GroupUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class GroupUseCase: GroupUseCaseProtocol {
    private let service: GroupServiceProtocol
    
    init(service: GroupServiceProtocol = GroupService()) {
        self.service = service
    }
    
    /// 그룹 생성
    func executePostGenerate(group: GroupGenerateRequest) -> AnyPublisher<ResponseData<GroupGenerateResponse>, Moya.MoyaError> {
        service.postGenerate(group: group)
    }
    
    /// 그룹 초대 코드로 가입
    func executePostJoin(inviteCode: GroupJoinRequest) -> AnyPublisher<ResponseData<GroupJoinResponse>, Moya.MoyaError> {
        service.postJoin(inviteCode: inviteCode)
    }
    
    /// 그룹 유저 조회
    func executeGetGroupMember(path: GroupMemberPath) -> AnyPublisher<ResponseData<GroupMemberResponse>, Moya.MoyaError> {
        service.getGroupMember(path: path)
    }
    
    /// 사용자가 속한 그룹 조회
    func executeGetGroupList(query: GroupUserQuery) -> AnyPublisher<ResponseData<GroupUserResponse>, Moya.MoyaError> {
        service.getGroupList(query: query)
    }
    
    /// 초대 코드로 그룹 정보 조회
    func executeGetInviteGroup(path: GroupInfoPath) -> AnyPublisher<ResponseData<GroupInfoResponse>, Moya.MoyaError> {
        service.getInviteGroup(path: path)
    }
    
    /// 그룹 탈퇴
    func executeDeleteGroup(path: GroupDeletePath) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.deleteGroup(path: path)
    }
}
