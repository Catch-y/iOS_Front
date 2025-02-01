//
//  GroupInviteService.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [초대 코드로 그룹 정보 조회] Service 객체
class GroupInviteService: GroupInviteServiceProtocol {
    private let provider: MoyaProvider<GroupInviteAPITarget>
    
    init(provider: MoyaProvider<GroupInviteAPITarget> = MoyaProvider<GroupInviteAPITarget>()) {
        self.provider = provider
    }
    
    func getGroupInvite(inviteCode: String) -> AnyPublisher<ResponseData<BaseResponseGroupInviteResult>, MoyaError> {
        return provider.requestPublisher(.getGroupInvite(inviteCode: inviteCode))
            .map(ResponseData<BaseResponseGroupInviteResult>.self)
            .eraseToAnyPublisher()
    }
}
