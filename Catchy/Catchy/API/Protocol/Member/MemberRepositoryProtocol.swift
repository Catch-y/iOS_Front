//
//  MemberServiceProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation
import Moya
import Combine

protocol MemberRepositoryProtocol {
    func patchNicknameData(nickname: String) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    
    /* 카테고리 전달 */
    func postServeyCategoryData(categories: [String]) -> AnyPublisher<ResponseData<StepOneResponse>, MoyaError>
    
    /* 코스 상세 시간 전달 */
    func postServeyStyleTimeData(styleTime: StepThirdRequest) -> AnyPublisher<ResponseData<StepTwoResponse>, MoyaError>
    
    /* 위치 정보 전달 */
    func postLocationData(locations: [StepFourStep]) -> AnyPublisher<ResponseData<StepThirdResponse>, MoyaError>
}
