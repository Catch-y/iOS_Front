//
//  MemberServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Combine
import Moya

protocol MemberUseCaseProtocol {
    
    func executePostNickname(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    
    /* 닉네임 변경 */
    func executePatchNickname(nickname: String) -> AnyPublisher<ResponseData<PatchNicknameResponse>, MoyaError>
    
    /* 카테고리 전달 */
    func executePostServeyCategory(categories: [String]) -> AnyPublisher<ResponseData<StepOneResponse>, MoyaError>
    
    /* 코스 상세 시간 전달 */
    func executePostServeyStyleTime(styleTime: StepThirdRequest) -> AnyPublisher<ResponseData<StepTwoResponse>, MoyaError>
    
    /* 위치 정보 전달 */
    func executePostLocation(locations: [StepFourStep]) -> AnyPublisher<ResponseData<StepThirdResponse>, MoyaError>
    
}
