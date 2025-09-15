//
//  MemberRouter.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/11/25.
//

import Foundation
import Moya

enum MemberRouter {
    /// 사용자 취향 설문 참여 스타일
    case postyStyke(style: MemberStyleTimeRequest)
    /// 사용자 취향설문 선호지역
    case postLocation(location: MemberLocationRequest)
    /// 사용자 취향설문 카테고리
    case postCategory(category: MemberCategoryRequest)
    /// 소셜 회원가입
    case postSocialSignup(path: MemberSignupPath, member: MemberSignupRequest, profileImage: Data?)
    /// 닉네임 중복 검사
    case postCheckNickname(nickname: MemberNicknameCheckRequest)
    /// 닉네임 변경
    case patchNickname(nickname: MemberNicknameCheckRequest)
    /// 로그아웃
    case postLogout
    /// 소셜 로그인
    case postSocialLogin(path: MemberSocialLoginPlatformPath, member: MemberSocialLoginRequest)
    /// 프로필 사진 변경
    case patchProfileImage(image: MemberProfileImageModifyRequest)
    /// FCM 토큰 갱신
    case patchFCMToken(token: MemberFCMTokenRequest)
    /// 토큰 검사 및 재발급
    case getTokenRefresh
    /// 프로필 조회
    case getMypage
    /// 회원 탈퇴
    case deleteMember(query: MemberDeleteUserQuery)
    /// 북마크된 코스 무한 스크롤
    case getBookMarkCourse(query: MemberMyBookMarkQuery)
}

extension MemberRouter: APITargetType {
    var path: String {
        switch self {
        case .postyStyke:
            return "/member/survey/styletime"
        case .postLocation:
            return "/member/survey/location"
        case .postCategory:
            return "/member/survey/category"
        case .postSocialSignup(let path, _, _):
            return "/member/signup/\(path.platform)"
        case .postCheckNickname:
            return "/member/mypage/nickname"
        case .patchNickname:
            return "/member/mypage/nickname"
        case .postLogout:
            return "/member/mypage/logout"
        case .postSocialLogin(let path, _):
            return "/member/login/\(path.platform)"
        case .patchProfileImage:
            return "/member/mypage/profileImage"
        case .patchFCMToken:
            return "/member/fcm-token"
        case .getTokenRefresh:
            return "/member/reissue"
        case .getMypage:
            return "/member/mypage"
        case .deleteMember:
            return "/member/withdraw"
        case .getBookMarkCourse:
            return "/mypage/bookmark"
        }
    }
    
    var method: Moya.Method {
        <#code#>
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
    
}
