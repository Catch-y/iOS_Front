//
//  GroupMembersService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 유저 조회] Service 객체
class GroupMembersService: GroupMembersServiceProtocol {
    private let provider: MoyaProvider<GroupMembersAPITarget>
    
    init(provider: MoyaProvider<GroupMembersAPITarget> = MoyaProvider<GroupMembersAPITarget>()) {
        self.provider = provider
    }
    
    func getGroupMembers(groupMemberRequest: GroupMembersRequest) -> AnyPublisher<ResponseData<BaseResponseListGroupMemberResponse>, MoyaError> {
        return provider.requestPublisher(.getGroupMembers(groupMemberRequest: groupMemberRequest))
            .map(ResponseData<BaseResponseListGroupMemberResponse>.self)
            .eraseToAnyPublisher()
    }
}
