//
//  GroupInviteRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [초대 코드로 그룹 정보 조회] Repository 객체
class GroupInviteRepository: GroupInviteRepositoryProtocol {
    private let service: GroupInviteServiceProtocol
    
    init(service: GroupInviteServiceProtocol = GroupInviteService()) {
        self.service = service
    }
    
    func getGroupInvite(inviteCode: String) -> AnyPublisher<ResponseData<BaseResponseGroupInviteResult>, Error> {
        return service.getGroupInvite(inviteCode: inviteCode)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
