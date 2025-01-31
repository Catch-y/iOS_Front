//
//  CourseRepositoryProtocol.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [Course] RepositoryProtocol
protocol CourseRepositoryProtocol {
    
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegisterData(place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError>
    
    /// 코스 리뷰 작성 API
    func postCourseReviewData(course: CourseReviewRequest) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError>
    
    /// 코스 생성(DIY) API
    func postCreateCourseDIYData(course: CourseDIYCreateRequest) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError>
    
    /// 코스 생성(AI) API
    func postCreateCourseAIData() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError>
    
    /// 코스 삭제 API
    func deleteCourseData(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError>
    
    /// 코스 수정 API
    func patchCourseEditData(course: CourseEditRequest) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError>
    
    /// 코스 북마크 API
    func patchCourseBookmarkData(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError>
    
    /// 장소 방문체크 API
    func patchPlaceVisitData(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError>
    
    /// 내 코스 조회 API
    func getCourseListData(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
    
    /// 장소 검색 - 지역명 기반
    func getPlaceListData(placeSearchRequest: PlaceSearchRequest) -> AnyPublisher<ResponseData<PlaceSearchResponse>, MoyaError>
    

}

