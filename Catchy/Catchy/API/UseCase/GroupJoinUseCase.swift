//
//  GroupJoinUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/1/25.
//

import Foundation
import Combine

/// [그룹 초대 코드로 가입] UseCase 객체
class GroupJoinUseCase: GroupJoinUseCaseProtocol {
    private let repository: GroupJoinRepositoryProtocol
    
    init(repository: GroupJoinRepositoryProtocol = GroupJoinRepository()) {
        self.repository = repository
    }
    
    func executeGroupJoin(request: GroupJoinRequest) -> AnyPublisher<ResponseData<BaseResponseGroupJoinResponse>, Error> {
        return repository.postGroupJoin(groupJoinRequest: request)
    }
}
