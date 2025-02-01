//
//  MyPageServiceProtocol.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// 마이페이지 ServiceProtocol
protocol MyPageServiceProtocol {
    
    /// 프로필 조회 
    func getProfile() -> AnyPublisher<ResponseData<ProfileResponse>, MoyaError>
}
