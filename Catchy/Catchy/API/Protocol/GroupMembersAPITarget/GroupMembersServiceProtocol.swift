//
//  GroupMembersServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [그룹 유저 조회] Service Protocol
protocol GroupMembersServiceProtocol {
    func getGroupMembers(groupMemberRequest: GroupMembersRequest) -> AnyPublisher<ResponseData<BaseResponseListGroupMemberResponse>, MoyaError>
}
