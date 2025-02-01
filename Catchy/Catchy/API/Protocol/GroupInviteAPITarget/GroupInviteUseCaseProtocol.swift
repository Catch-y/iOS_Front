
//
//  GroupInviteUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [초대 코드로 그룹 정보 조회] UseCase Protocol
protocol GroupInviteUseCaseProtocol {
    func executeGetGroupInvite(inviteCode: String) -> AnyPublisher<ResponseData<BaseResponseGroupInviteResult>, Error>
}
