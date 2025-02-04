//
//  MemberRepository.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

class MemberRepository: MemberRepositoryProtocol {
    let service: MemberServiceProtocol
    
    init(service: MemberServiceProtocol = MemberService()) {
        self.service = service
    }
    
    func patchNicknameData(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError> {
        return service.patchNickname(nickname: nickname)
    }
}
