//
//  MemberUseCase.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

class MemberUseCase: MemberUseCaseProtocol {
    
    let repository: MemberRepositoryProtocol
    
    init(repository: MemberRepositoryProtocol = MemberRepository()) {
        self.repository = repository
    }
    
    func executePostNickname(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError> {
        return repository.postNickname(nickname: nickname)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePatchNickname(nickname: String) -> AnyPublisher<ResponseData<PatchNicknameResponse>, MoyaError> {
        return repository.patchNicknameData(nickname: nickname)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePostServeyCategory(categories: [String]) -> AnyPublisher<ResponseData<StepOneResponse>, MoyaError> {
        return repository.postServeyCategoryData(categories: categories)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePostServeyStyleTime(styleTime: StepThirdRequest) -> AnyPublisher<ResponseData<StepTwoResponse>, MoyaError> {
        return repository.postServeyStyleTimeData(styleTime: styleTime)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePostLocation(locations: [StepFourStep]) -> AnyPublisher<ResponseData<StepThirdResponse>, MoyaError> {
        return repository.postLocationData(locations: locations)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePatchFCMToken(token: String) -> AnyPublisher<ResponseData<EmptyResult>, Moya.MoyaError> {
        return repository.patchFCMToken(token: token)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    
}
