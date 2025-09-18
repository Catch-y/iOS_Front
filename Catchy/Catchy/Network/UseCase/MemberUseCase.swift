//
//  MemberUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class MemberUseCase: MemberUseCaseProtocol {
    private let service: MemberServiceProtocol
    
    init(service: MemberServiceProtocol = MemberService()) {
        self.service = service
    }
    
    /// 사용자 취향 설문 참여 스타일
    func executePostyStyle(style: MemberStyleTimeRequest) -> AnyPublisher<ResponseData<MemeberStyleTimeResponse>, Moya.MoyaError> {
        service.postyStyle(style: style)
    }
    
    /// 사용자 취향설문 선호지역
    func executePostLocation(location: MemberLocationRequest) -> AnyPublisher<ResponseData<MemberLocationResponse>, Moya.MoyaError> {
        service.postLocation(location: location)
    }
    
    /// 사용자 취향설문 카테고리
    func executePostCategory(category: MemberCategoryRequest) -> AnyPublisher<ResponseData<MemberCategoryResponse>, Moya.MoyaError> {
        service.postCategory(category: category)
    }
    /// 소셜 회원 가입
   
    func executePostSocialSignup(path: MemberSignupPath, member: MemberSignupRequest, profileImage: Data?) -> AnyPublisher<ResponseData<MemberSignupResponse>, Moya.MoyaError> {
        service.postSocialSignup(path: path, member: member, profileImage: profileImage)
    }
    
    /// 닉네임 중복 검사
    func executePostCheckNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.postCheckNickname(nickname: nickname)
    }
    
    /// 닉네임 변경
    func executePatchNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<MemberNicknameModifyResponse>, Moya.MoyaError> {
        service.patchNickname(nickname: nickname)
    }
    
    /// 로그아웃
    func executePostLogout() -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.postLogout()
    }
    
    /// 소셜 로그인
    func executePostSocialLogin(path: MemberSocialLoginPlatformPath, member: MemberSocialLoginRequest) -> AnyPublisher<ResponseData<MemberSocialLoginResponse>, Moya.MoyaError> {
        service.postSocialLogin(path: path, member: member)
    }
    
    /// 프로필 사진 변경
    func executePatchProfileImage(image: MemberProfileImageModifyRequest) -> AnyPublisher<ResponseData<MemeberProfileImageModifyResponse>, Moya.MoyaError> {
        service.patchProfileImage(image: image)
    }
    
    /// FCM 토큰 갱신
    func executePatchFCMToken(token: MemberFCMTokenRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.patchFCMToken(token: token)
    }
    
    /// 토큰 검사 및 재발급
    func executeGetTokenRefresh(token: String) -> AnyPublisher<ResponseData<MemberReIssueResponse>, Moya.MoyaError> {
        service.getTokenRefresh(token: token)
    }
    
    /// 프로필 조회
    func executeGetMypage() -> AnyPublisher<ResponseData<MemberProfileInfoResponse>, Moya.MoyaError> {
        service.getMypage()
    }
    
    /// 회원 탈퇴
    func executeDeleteMember(query: MemberDeleteUserQuery) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.deleteMember(query: query)
    }
    
    /// 북마크된 코스 무한 스크롤
    func executeGetBookMarkCourse(query: MemberMyBookMarkQuery) -> AnyPublisher<ResponseData<MemberMyBookMarkResponse>, Moya.MoyaError> {
        service.getBookMarkCourse(query: query)
    }
}
