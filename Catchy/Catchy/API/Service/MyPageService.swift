//
//  MyPageService.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 Service
class MyPageService: MyPageServiceProtocol {

    
    let provider: MoyaProvider<MyPageAPITarget>
    
    init(provider: MoyaProvider<MyPageAPITarget> = APIManager.shared.testProvider(for: MyPageAPITarget.self)){
        self.provider = provider
    }
    
    /// 프로필 조회
    func getProfile() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError> {
        return provider.requestPublisher(.getProfile)
            .map(ResponseData<ProfileResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getBookmarkCourseList(pageSize: Int, lastCourseId: Int? = nil) -> AnyPublisher<ResponseData<CourseResponse>, Moya.MoyaError> {
        return provider.requestPublisher(.getBookmarkCourseList(pageSize: pageSize, lastCourseId: lastCourseId))
            .map(ResponseData<CourseResponse>.self)
            .eraseToAnyPublisher()
    }
    
}
