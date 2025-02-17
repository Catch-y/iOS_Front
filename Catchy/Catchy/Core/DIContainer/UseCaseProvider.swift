//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    
    /// [투표 카테고리] UseCase
    var voteUseCase : VoteUseCase {get set}
    /// [그룹생성] UseCase
    var groupUseCase : GroupUseCase { get set }
   
    /// [Course] UseCase
    var courseUseCase: CourseUseCase { get set }
    
    /// [PlaceCourse] UseCase
    var placeCourseUseCase: PlaceCourseUseCase { get set }
    
    /// [Place] Usecase
    var placeUseCase: PlaceUseCase { get set }
    
    /// 리뷰 전체보기
    var reviewUseCase: ReviewUseCase { get set }
    
    /// 리뷰 신고하기
    var reviewReportUseCase: ReviewReportUseCase { get set }
    
    /// 유저 관련
    var memberUseCase: MemberUseCase { get set }
  
    var myPageUseCase: MyPageUseCase { get set }
    
    var homeUseCase: HomeUseCase { get set }
}

class UseCaseProvider: UseCaseProtocol {
  
    var authUseCase: AuthUseCase
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase
    /// [그룹 관리 ] UseCase
    var groupUseCase : GroupUseCase
    
    /// [투표 관리] UseCase
    var voteUseCase : VoteUseCase
  
    /// [Course] UseCase
    var courseUseCase: CourseUseCase
    
    /// [PlaceCourse] UseCase
    var placeCourseUseCase: PlaceCourseUseCase
    
    /// [Place] Usecase
    var placeUseCase: PlaceUseCase
    
    /// 리뷰 전체보기
    var reviewUseCase: ReviewUseCase
    
    /// 리뷰 신고하기
    var reviewReportUseCase: ReviewReportUseCase
    
    var memberUseCase: MemberUseCase
    
    var homeUseCase: HomeUseCase
        
    var myPageUseCase: MyPageUseCase
  
    init() {
        self.authUseCase = AuthUseCase()
        self.courseUseCase = CourseUseCase()
        self.placeCourseUseCase = PlaceCourseUseCase()
        self.reviewUseCase = ReviewUseCase()
        self.reviewReportUseCase = ReviewReportUseCase()
        self.placeUseCase = PlaceUseCase()
        self.memberUseCase = MemberUseCase()
        self.myPageUseCase = MyPageUseCase()
        self.homeUseCase = HomeUseCase()
         self.groupUseCase = GroupUseCase()
        self.voteUseCase = VoteUseCase ()
    }
    
    
}
