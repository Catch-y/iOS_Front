//
//  PlaceCourseRepository.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] Repository 객체
class PlaceCourseRepository: PlaceCourseRepositoryProtocol {
    
    let provider: PlaceCourseServiceProtocol
    
    init(provider: PlaceCourseServiceProtocol = PlaceCourseService()) {
        self.provider = provider
    }

    /// 장소 검색 - 상세 화면
    func getPlaceDetailData(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError> {
        return provider.getPlaceDetail(placeId: placeId)
    }
}
