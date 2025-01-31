//
//  CourseServiceProtocol.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] ServiceProtocol
protocol CourseServiceProtocol {
    
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegister(place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError>
    
    /// 코스 리뷰 작성 API
    func postCourseReview(course: CourseReviewRequest) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError>
    
    /// 코스 생성(DIY) API
    func postCreateCourseDIY(course: CourseDIYCreateRequest) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError>
    
    /// 코스 생성(AI) API
    func postCreateCourseAI() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError>
    
    /// 코스 삭제 API
    func deleteCourse(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError>
    
    /// 코스 수정 API
    func pathCourseEdit(course: CourseEditRequest) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError>
    
    /// 코스 북마크 API
    func patchCourseBookmark(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError>
    
    /// 장소 방문체크 API
    func patchPlaceVisit(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError>
    
    /// 내 코스 조회 API
    func getCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    
    /// 장소 검색 - 지역명 기반
    func getPlaceList(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>

    
}
