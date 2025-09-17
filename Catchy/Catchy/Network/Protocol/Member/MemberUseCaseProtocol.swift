//
//  MemberUseCaseProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol MemberUseCaseProtocol {
    /// 사용자 취향 설문 참여 스타일
    func executePostyStyke(style: MemberStyleTimeRequest) -> AnyPublisher<ResponseData<MemeberStyleTimeResponse>, MoyaError>
    /// 사용자 취향설문 선호지역
    func executePostLocation(location: MemberLocationRequest) -> AnyPublisher<ResponseData<MemberLocationResponse>, MoyaError>
    /// 사용자 취향설문 카테고리
    func executePostCategory(category: MemberCategoryRequest) -> AnyPublisher<ResponseData<MemberCategoryResponse>, MoyaError>
    /// 소셜 회원가입
    func executePostSocialSignup(path: MemberSignupPath, member: MemberSignupRequest, profileImage: Data?) -> AnyPublisher<ResponseData<MemberSignupResponse>, MoyaError>
    /// 닉네임 중복 검사
    func executePostCheckNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 닉네임 변경
    func executePatchNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<MemberNicknameModifyResponse>, MoyaError>
    /// 로그아웃
    func executePostLogout() -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 소셜 로그인
    func executePostSocialLogin(path: MemberSocialLoginPlatformPath, member: MemberSocialLoginRequest) -> AnyPublisher<ResponseData<MemberSocialLoginResponse>, MoyaError>
    /// 프로필 사진 변경
    func executePatchProfileImage(image: MemberProfileImageModifyRequest) -> AnyPublisher<ResponseData<MemeberProfileImageModifyResponse>, MoyaError>
    /// FCM 토큰 갱신
    func executePatchFCMToken(token: MemberFCMTokenRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 토큰 검사 및 재발급
    func executeGetTokenRefresh() -> AnyPublisher<ResponseData<MemberReIssueResponse>, MoyaError>
    /// 프로필 조회
    func executeGetMypage() -> AnyPublisher<ResponseData<MemberProfileInfoResponse>, MoyaError>
    /// 회원 탈퇴
    func executeDeleteMember(query: MemberDeleteUserQuery) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 북마크된 코스 무한 스크롤
    func executeGetBookMarkCourse(query: MemberMyBookMarkQuery) -> AnyPublisher<ResponseData<MemberMyBookMarkResponse>, MoyaError>
}
