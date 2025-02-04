//
//  MemberServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya
import Combine

protocol MemberServiceProtocol {
    
    /* 닉네임 중복 검사 */
    func patchNickname(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    
}
