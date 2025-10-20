//
//  MemberService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class MemberService: MemberServiceProtocol, BaseAPIService {
    typealias Target = MemberRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(
        provider: MoyaProvider<Target> = APIManager.shared.createProvider(for: Target.self),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func postyStyle(style: MemberStyleTimeRequest) -> AnyPublisher<ResponseData<MemeberStyleTimeResponse>, Moya.MoyaError> {
        request(.postyStyle(style: style))
    }
    
    func postLocation(location: MemberLocationRequest) -> AnyPublisher<ResponseData<MemberLocationResponse>, Moya.MoyaError> {
        request(.postLocation(location: location))
    }
    
    func postCategory(category: MemberCategoryRequest) -> AnyPublisher<ResponseData<MemberCategoryResponse>, Moya.MoyaError> {
        request(.postCategory(category: category))
    }
    
    func postSocialSignup(path: MemberSignupPath, member: MemberSignupRequest, profileImage: Data?) -> AnyPublisher<ResponseData<MemberSignupResponse>, Moya.MoyaError> {
        request(.postSocialSignup(path: path, member: member, profileImage: profileImage))
    }
    
    func postCheckNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.postCheckNickname(nickname: nickname))
    }
    
    func patchNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<MemberNicknameModifyResponse>, Moya.MoyaError> {
        request(.patchNickname(nickname: nickname))
    }
    
    func postLogout() -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.postLogout)
    }
    
    func postSocialLogin(path: MemberSocialLoginPlatformPath, member: MemberSocialLoginRequest) -> AnyPublisher<ResponseData<MemberSocialLoginResponse>, Moya.MoyaError> {
        request(.postSocialLogin(path: path, member: member))
    }
    
    func patchProfileImage(image: MemberProfileImageModifyRequest) -> AnyPublisher<ResponseData<MemeberProfileImageModifyResponse>, Moya.MoyaError> {
        request(.patchProfileImage(image: image))
    }
    
    func patchFCMToken(token: MemberFCMTokenRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.patchFCMToken(token: token))
    }
    
    func getTokenRefresh(token: String) -> AnyPublisher<ResponseData<MemberReIssueResponse>, Moya.MoyaError> {
        request(.getTokenRefresh(token: token))
    }
    
    func getMypage() -> AnyPublisher<ResponseData<MemberProfileInfoResponse>, Moya.MoyaError> {
        request(.getMypage)
    }
    
    func deleteMember(query: MemberDeleteUserQuery) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.deleteMember(query: query))
    }
    
    func getBookMarkCourse(query: MemberMyBookMarkQuery) -> AnyPublisher<ResponseData<MemberMyBookMarkResponse>, Moya.MoyaError> {
        request(.getBookMarkCourse(query: query))
    }
    
}
