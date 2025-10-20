//
//  CourseService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Combine
import Moya

class CourseService: CourseServiceProtocol, BaseAPIService {
    typealias Target = CourseRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(
        provider: MoyaProvider<Target> = APIManager.shared.createProvider(for: Target.self),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func postSelectCategory(path: CourseCategoryPath, category: CourseCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.postSelectCategory(path: path, category: category))
    }
    
    func postReview(path: CourseReviewWritePath, review: CourseReviewWriteRequest) -> AnyPublisher<ResponseData<CourseReviewWriteResponse>, Moya.MoyaError> {
        request(.postReview(path: path, review: review))
    }
    
    func postVisited(path: CourseCheckPath) -> AnyPublisher<ResponseData<CourseCheckResponse>, Moya.MoyaError> {
        request(.postVisited(path: path))
    }
    
    func postCoursePerson(course: CourseGenerateUserRequest) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        request(.postCoursePerson(course: course))
    }
    
    func postCourseAI() -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        request(.postCourseAI)
    }
    
    func deleteCourse(path: CourseDeletePath) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.deleteCourse(path: path))
    }
    
    func patchModifyCourse(path: CourseModifyPath, course: CourseModifyRequest) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        request(.patchModifyCourse(path: path, course: course))
    }
    
    func patchBookmark(path: CourseBookMarkPath) -> AnyPublisher<ResponseData<CourseBookMarkResponse>, Moya.MoyaError> {
        request(.patchBookmark(path: path))
    }
    
    func getCourseReview(path: CourseReviewAllPath, query: CourseReviewAllQuery) -> AnyPublisher<ResponseData<CourseReviewAllResponse>, Moya.MoyaError> {
        request(.getCourseReview(path: path, query: query))
    }
    
    func getBestCourse() -> AnyPublisher<ResponseData<CourseBestResponse>, Moya.MoyaError> {
        request(.getBestCourse)
    }
    
    func getMyCourseList(query: CourseMyQuery) -> AnyPublisher<ResponseData<CourseMyResponse>, Moya.MoyaError> {
        request(.getMyCourseList(query: query))
    }
    
    func getHomeRecommendCourse() -> AnyPublisher<ResponseData<CourseRecommendResponse>, Moya.MoyaError> {
        request(.getHomeRecommendCourse)
    }
    
    func getCourseDetail(path: CourseDetailInfoPath) -> AnyPublisher<ResponseData<CourseGenerateUserResponse>, Moya.MoyaError> {
        request(.getCourseDetail(path: path))
    }
}
