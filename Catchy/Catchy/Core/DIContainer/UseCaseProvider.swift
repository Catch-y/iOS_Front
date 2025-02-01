//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase { get set }
    
    /// [Place] Usecase
    var placeUseCase: PlaceUseCase { get set }
    
    /// 리뷰 전체보기
    var reviewUseCase: ReviewUseCase { get set }
    
    /// 리뷰 신고하기
    var reviewReportUseCase: ReviewReportUseCase { get set }
}

class UseCaseProvider: UseCaseProtocol {
    var authUseCase: AuthUseCase
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase
    
    /// [Place] Usecase
    var placeUseCase: PlaceUseCase
    
    /// 리뷰 전체보기
    var reviewUseCase: ReviewUseCase
    
    /// 리뷰 신고하기
    var reviewReportUseCase: ReviewReportUseCase
    
    init() {
        self.authUseCase = AuthUseCase()
        self.courseManagementUseCase = CourseManagementUseCase()
        self.reviewUseCase = ReviewUseCase()
        self.reviewReportUseCase = ReviewReportUseCase()
        self.placeUseCase = PlaceUseCase()
    }
}
