//
//  GroupJoinService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [그룹 초대 코드로 가입] Service 객체
class GroupJoinService: GroupJoinServiceProtocol {
    private let provider: MoyaProvider<GroupJoinAPITarget>
    
    init(provider: MoyaProvider<GroupJoinAPITarget> = MoyaProvider<GroupJoinAPITarget>()) {
        self.provider = provider
    }
    
    func postGroupJoin(groupJoinRequest: GroupJoinRequest) -> AnyPublisher<ResponseData<BaseResponseGroupJoinResponse>, MoyaError> {
        return provider.requestPublisher(.postGroupJoin(groupJoinRequest: groupJoinRequest))
            .map(ResponseData<BaseResponseGroupJoinResponse>.self)
            .eraseToAnyPublisher()
    }
}
