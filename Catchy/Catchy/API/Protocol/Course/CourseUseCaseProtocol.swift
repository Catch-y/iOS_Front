//
//  CourseUseCaseProtocol.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] UseCaseProtocol
protocol CourseUseCaseProtocol {
    
    /// 장소 카테고리 선택 API
    func executePostPlaceCategoryRegister(place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError>
    
    /// 코스 리뷰 작성 API
    func executePostCourseReview(course: CourseReviewRequest) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError>
    
    /// 코스 생성(DIY) API
    func executePostCreateCourseDIY(course: CourseDIYCreateRequest) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError>
    
    /// 코스 생성(AI) API
    func executePostCreateCourseAI() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError>
    
    /// 코스 삭제 API
    func executeDeleteCourse(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError>
    
    /// 코스 수정 API
    func executePatchCourseEdit(course: CourseEditRequest) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError>
    
    /// 코스 북마크 API
    func executePatchCourseBookmark(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError>
    
    /// 장소 방문체크 API
    func executePatchPlaceVisit(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError>
    
    /// 내 코스 조회 API
    func executeGetCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 코스 상제정보 조회 API
    func executeGetCourseDetail(courseId: Int) -> AnyPublisher<ResponseData<CourseDetailResponse>, MoyaError>
}
