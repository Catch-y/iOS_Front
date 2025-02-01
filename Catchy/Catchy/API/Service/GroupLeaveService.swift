//
//  GroupLeaveService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 탈퇴] Service 객체
class GroupLeaveService: GroupLeaveServiceProtocol {
    private let provider: MoyaProvider<GroupLeaveAPITarget>
    
    init(provider: MoyaProvider<GroupLeaveAPITarget> = MoyaProvider<GroupLeaveAPITarget>()) {
        self.provider = provider
    }
    
    func deleteGroupLeave(groupLeaveRequest: GroupLeaveRequest) -> AnyPublisher<ResponseData<GroupLeaveResponse>, MoyaError> {
        return provider.requestPublisher(.deleteGroupLeave(groupLeaveRequest: groupLeaveRequest))
            .map(ResponseData<GroupLeaveResponse>.self)
            .eraseToAnyPublisher()
    }
}
