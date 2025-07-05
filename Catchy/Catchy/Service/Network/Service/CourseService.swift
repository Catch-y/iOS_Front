//
//  CourseService.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import UIKit

/// [Course] Service 객체
class CourseService: CourseServiceProtocol {
    
    let provider: MoyaProvider<CourseAPITarget>
    
    init(provider: MoyaProvider<CourseAPITarget> = APIManager.shared.createProvider(for: CourseAPITarget.self)){
        self.provider = provider
    }
    
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegister(placeId: Int, place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError> {
        return provider.requestPublisher(.postPlaceCategoryRegister(placeId: placeId, place: place))
            .map(ResponseData<PlaceCategoryRegisterResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 리뷰 작성 API
    func postCourseReview(courseId: Int, course: CourseReviewRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError> {
        return provider.requestPublisher(.postCourseReview(courseId: courseId, course: course, reviewImages: reviewImages))
            .map(ResponseData<CourseReviewResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 생성(DIY) API
    func postCreateCourseDIY(course: CourseDIYCreateRequest, courseImage: [UIImage]) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateCourseDIY(course: course, courseImage: courseImage))
            .map(ResponseData<CourseDIYCreateResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 생성(AI) API
    func postCreateCourseAI() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateCourseAI)
            .map(ResponseData<CourseAICreateResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 삭제 API
    func deleteCourse(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError> {
        return provider.requestPublisher(.deleteCourse(courseId: courseId))
            .map(ResponseData<CourseDeleteResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 수정 API
    func patchCourseEdit(courseId: Int, course: CourseEditRequest, courseImage: UIImage) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError> {
        return provider.requestPublisher(.patchCourseEdit(courseId: courseId, course: course, courseImage: courseImage))
            .map(ResponseData<CourseEditResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 코스 북마크 API
    func patchCourseBookmark(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError> {
        return provider.requestPublisher(.patchCourseBookmark(courseId: courseId))
            .map(ResponseData<CourseBookmarkResponse>.self)
            .eraseToAnyPublisher()
    }
    
    /// 장소 방문체크 API
    func postPlaceVisit(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError> {
        return provider.requestPublisher(.postPlaceVisit(placeId: placeId))
            .map(ResponseData<PlaceVisitResponse>.self)
            .eraseToAnyPublisher()
    }
    
    
    /// 내 코스 조회 API
    func getCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return provider.requestPublisher(.getCourseList(course: courseRequest))
            .map(ResponseData<CourseResponse>.self)
            .eraseToAnyPublisher()
            
    }
    
    /// 코스 상세정보 조회 API
    func getCourseDetail(courseId: Int) -> AnyPublisher<ResponseData<CourseDetailResponse>, MoyaError> {
        return provider.requestPublisher(.getCourseDetail(courseId: courseId))
            .map(ResponseData<CourseDetailResponse>.self)
            .eraseToAnyPublisher()
    }
    
    
}
