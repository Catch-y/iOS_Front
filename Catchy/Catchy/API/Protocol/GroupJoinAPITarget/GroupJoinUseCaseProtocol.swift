//
//  GroupJoinUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 초대 코드로 가입] UseCase Protocol
protocol GroupJoinUseCaseProtocol {
    func executeGroupJoin(request: GroupJoinRequest) -> AnyPublisher<ResponseData<BaseResponseGroupJoinResponse>, Error>
}
