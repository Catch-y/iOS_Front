//
//  GroupJoinRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 초대 코드로 가입] Repository 객체
class GroupJoinRepository: GroupJoinRepositoryProtocol {
    private let service: GroupJoinServiceProtocol
    
    init(service: GroupJoinServiceProtocol = GroupJoinService()) {
        self.service = service
    }
    
    func postGroupJoin(groupJoinRequest: GroupJoinRequest) -> AnyPublisher<ResponseData<BaseResponseGroupJoinResponse>, Error> {
        return service.postGroupJoin(groupJoinRequest: groupJoinRequest)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
