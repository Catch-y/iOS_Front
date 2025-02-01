//
//  CreateGroupUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 생성] UseCase Protocol
protocol CreateGroupUseCaseProtocol {
    func executeCreateGroup(creategroup: CreateGroupRequest) -> AnyPublisher<ResponseData<CreateGroupResponse>, Error>
}
