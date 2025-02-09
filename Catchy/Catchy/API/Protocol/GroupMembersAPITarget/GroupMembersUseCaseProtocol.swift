//
//  GroupMembersUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 유저 조회] UseCase Protocol
protocol GroupMembersUseCaseProtocol {
    func executeGetGroupMembers(groupMemberRequest: GroupMembersRequest) -> AnyPublisher<ResponseData<BaseResponseListGroupMemberResponse>, Error>
}
