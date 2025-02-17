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
    
    func postServeyCategoryData(categories: [String]) -> AnyPublisher<ResponseData<StepOneResponse>, MoyaError> {
        return service.postServeyCategory(categories: categories)
    }
    
    func postServeyStyleTimeData(styleTime: StepThirdRequest) -> AnyPublisher<ResponseData<StepTwoResponse>, MoyaError> {
        return service.postServeyStyleTime(styleTime: styleTime)
    }
    
    func postLocationData(locations: [StepFourStep]) -> AnyPublisher<ResponseData<StepThirdResponse>, MoyaError> {
        return service.postLocation(locations: locations)
    }
}
