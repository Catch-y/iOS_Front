//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    
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
}

class UseCaseProvider: UseCaseProtocol {
    var authUseCase: AuthUseCase
    
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
    }
}
