//
//  CourseRepository.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import UIKit

/// [Course] Repository 객체
class CourseRepository: CourseRepositoryProtocol {
    
    let service: CourseServiceProtocol
    
    init(service: CourseServiceProtocol = CourseService()){
        self.service = service
    }
    
    /// 장소 카테고리 선택 API
    func postPlaceCategoryRegisterData(placeId: Int, place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError> {
        return service.postPlaceCategoryRegister(placeId: placeId, place: place)
    }
    
    /// 코스 리뷰 작성 API
    func postCourseReviewData(courseId: Int, course: CourseReviewRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError> {
        return service.postCourseReview(courseId: courseId, course: course, reviewImages: reviewImages)
    }
    
    /// 코스 생성(DIY) API
    func postCreateCourseDIYData(course: CourseDIYCreateRequest, courseImage: UIImage) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError> {
        return service.postCreateCourseDIY(course: course, courseImage: courseImage)
    }
    
    /// 코스 생성(AI) API
    func postCreateCourseAIData() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError> {
        return service.postCreateCourseAI()
    }
    
    /// 코스 삭제 API
    func deleteCourseData(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError> {
        return service.deleteCourse(courseId: courseId)
    }
    
    /// 코스 수정 API
    func patchCourseEditData(courseId: Int, course: CourseEditRequest, courseImage: UIImage) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError> {
        return service.patchCourseEdit(courseId: courseId, course: course, courseImage: courseImage)
    }
    
    /// 코스 북마크 API
    func patchCourseBookmarkData(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError> {
        return service.patchCourseBookmark(courseId: courseId)
    }
    
    /// 장소 방문체크 API
    func postPlaceVisitData(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError> {
        return service.postPlaceVisit(placeId: placeId)
    }
    
    /// 내 코스 조회 API
    func getCourseListData(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        return service.getCourseList(courseRequest: courseRequest)
    }
    
    /// 코스 상세정보 조회 APi
    func getCourseDetailData(courseId: Int) -> AnyPublisher<ResponseData<CourseDetailResponse>, MoyaError> {
        return service.getCourseDetail(courseId: courseId)
    }
}
