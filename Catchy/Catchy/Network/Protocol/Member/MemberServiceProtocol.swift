//
//  MemberServiceProtocol.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

protocol MemberServiceProtocol {
    /// 사용자 취향 설문 참여 스타일
    func postyStyle(style: MemberStyleTimeRequest) -> AnyPublisher<ResponseData<MemeberStyleTimeResponse>, MoyaError>
    /// 사용자 취향설문 선호지역
    func postLocation(location: MemberLocationRequest) -> AnyPublisher<ResponseData<MemberLocationResponse>, MoyaError>
    /// 사용자 취향설문 카테고리
    func postCategory(category: MemberCategoryRequest) -> AnyPublisher<ResponseData<MemberCategoryResponse>, MoyaError>
    /// 소셜 회원가입
    func postSocialSignup(path: MemberSignupPath, member: MemberSignupRequest, profileImage: Data?) -> AnyPublisher<ResponseData<MemberSignupResponse>, MoyaError>
    /// 닉네임 중복 검사
    func postCheckNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 닉네임 변경
    func patchNickname(nickname: MemberNicknameCheckRequest) -> AnyPublisher<ResponseData<MemberNicknameModifyResponse>, MoyaError>
    /// 로그아웃
    func postLogout() -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 소셜 로그인
    func postSocialLogin(path: MemberSocialLoginPlatformPath, member: MemberSocialLoginRequest) -> AnyPublisher<ResponseData<MemberSocialLoginResponse>, MoyaError>
    /// 프로필 사진 변경
    func patchProfileImage(image: MemberProfileImageModifyRequest) -> AnyPublisher<ResponseData<MemeberProfileImageModifyResponse>, MoyaError>
    /// FCM 토큰 갱신
    func patchFCMToken(token: MemberFCMTokenRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 토큰 검사 및 재발급
    func getTokenRefresh() -> AnyPublisher<ResponseData<MemberReIssueResponse>, MoyaError>
    /// 프로필 조회
    func getMypage() -> AnyPublisher<ResponseData<MemberProfileInfoResponse>, MoyaError>
    /// 회원 탈퇴
    func deleteMember(query: MemberDeleteUserQuery) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 북마크된 코스 무한 스크롤
    func getBookMarkCourse(query: MemberMyBookMarkQuery) -> AnyPublisher<ResponseData<MemberMyBookMarkResponse>, MoyaError>
}
