//
//  GroupMembersRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 유저 조회] Repository Protocol
protocol GroupMembersRepositoryProtocol {
    func getGroupMembers(groupMemberRequest: GroupMembersRequest) -> AnyPublisher<ResponseData<BaseResponseListGroupMemberResponse>, Error>
}
