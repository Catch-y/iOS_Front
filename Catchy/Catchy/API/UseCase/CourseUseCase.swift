//
//  CourseUseCase.swift
//  Catchy
//
//  Created by LEE on 1/25/25.
//

import Foundation
import Combine
import CombineMoya
import Moya
import UIKit

/// [Course] UseCase 객체
class CourseUseCase: CourseUseCaseProtocol {
    
    let repository: CourseRepositoryProtocol
    
    init(repository: CourseRepositoryProtocol = CourseRepository()) {
        self.repository = repository
    }
    
    /// 장소 카테고리 선택 API
    func executePostPlaceCategoryRegister(placeId: Int, place: PlaceCategoryRegisterRequest) -> AnyPublisher<ResponseData<PlaceCategoryRegisterResponse>, MoyaError> {
        return repository.postPlaceCategoryRegisterData(placeId: placeId, place: place)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 코스 리뷰 작성 API
    func executePostCourseReview(courseId: Int, course: CourseReviewRequest, reviewImages: [UIImage]) -> AnyPublisher<ResponseData<CourseReviewResponse>, MoyaError> {
        return repository.postCourseReviewData(courseId: courseId, course: course, reviewImages: reviewImages)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 코스 생성(DIY) API
    func executePostCreateCourseDIY(course: CourseDIYCreateRequest, courseImage: [UIImage]) -> AnyPublisher<ResponseData<CourseDIYCreateResponse>, MoyaError> {
        return repository.postCreateCourseDIYData(course: course, courseImage: courseImage)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 코스 생성(AI) API
    func executePostCreateCourseAI() -> AnyPublisher<ResponseData<CourseAICreateResponse>, MoyaError> {
        return repository.postCreateCourseAIData()
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 코스 삭제 API
    func executeDeleteCourse(courseId: Int) -> AnyPublisher<ResponseData<CourseDeleteResponse>, MoyaError> {
        return repository.deleteCourseData(courseId: courseId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
        
    }
    
    /// 코스 수정 API
    func executePatchCourseEdit(courseId: Int, course: CourseEditRequest, courseImage: UIImage) -> AnyPublisher<ResponseData<CourseEditResponse>, MoyaError> {
        return repository.patchCourseEditData(courseId: courseId, course: course, courseImage: courseImage)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 코스 북마크 API
    func executePatchCourseBookmark(courseId: Int) -> AnyPublisher<ResponseData<CourseBookmarkResponse>, MoyaError> {
        return repository.patchCourseBookmarkData(courseId: courseId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 장소 방문체크 API
    func executePostPlaceVisit(placeId: Int) -> AnyPublisher<ResponseData<PlaceVisitResponse>, MoyaError> {
        return repository.postPlaceVisitData(placeId: placeId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 코스 조회
    func executeGetCourseList(courseRequest: CourseRequest) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError> {
        
        return repository.getCourseListData(courseRequest: courseRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    /// 코스 상세정보 조회 API
    func executeGetCourseDetail(courseId: Int) -> AnyPublisher<ResponseData<CourseDetailResponse>, MoyaError> {
        return repository.getCourseDetailData(courseId: courseId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    
}

