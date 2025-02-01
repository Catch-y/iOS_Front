//
//  GroupInviteRepositoryProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [초대 코드로 그룹 정보 조회] Repository Protocol
protocol GroupInviteRepositoryProtocol {
    func getGroupInvite(inviteCode: String) -> AnyPublisher<ResponseData<BaseResponseGroupInviteResult>, Error>
}
