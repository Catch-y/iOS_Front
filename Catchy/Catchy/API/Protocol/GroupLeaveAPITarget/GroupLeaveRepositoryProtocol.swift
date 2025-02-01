//
//  GroupLeaveRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 탈퇴] Repository Protocol
protocol GroupLeaveRepositoryProtocol {
    func deleteGroupLeave(groupLeaveRequest: GroupLeaveRequest) -> AnyPublisher<ResponseData<GroupLeaveResponse>, Error>
}
