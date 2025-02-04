//
//  MyPageRepositoryProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 RepositoryProtocol
protocol MyPageRepositoryProtocol {
    
    /// 프로필 조회
    func getProfileData() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError>
    
    func getBookmarkCourseListData(pageSize: Int, lastCourseId: Int?) -> AnyPublisher<ResponseData<CourseResponse>, MoyaError>
}

