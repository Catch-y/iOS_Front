//
//  MyPageUseCaseProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 UseCaseProtocol
protocol MyPageUseCaseProtocol {
    
    /// 프로필 조회
    func executeGetProfile() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError>
    
    func executeGetBookmarkCourseList(pageSize: Int, lastCourseId: Int?) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
}
