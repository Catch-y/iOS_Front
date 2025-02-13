//
//  GroupLeaveServiceProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import Moya

/// [그룹 탈퇴] Service Protocol
protocol GroupLeaveServiceProtocol {
    func deleteGroupLeave(groupLeaveRequest: GroupLeaveRequest) -> AnyPublisher<ResponseData<GroupLeaveResponse>, MoyaError>
}
