//
//  PlaceCourseService.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] Service 객체
class PlaceCourseService: PlaceCourseServiceProtocol {
    
    let provider: MoyaProvider<PlaceCourseAPITarget>
    
    init(provider: MoyaProvider<PlaceCourseAPITarget> = APIManager.shared.testProvider(for: PlaceCourseAPITarget.self)) {
        self.provider = provider
    }
    
    /// 장소 상세 화면 API
    func getPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.requestPublisher(.getPlaceDetail(placeId: placeId))
            .map(ResponseData<PlaceDetailResponse>.self)
            .eraseToAnyPublisher()
    }
}
