//
//  PlaceCourseUseCaseProtocol.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] UseCaseProtocol
protocol PlaceCourseUseCaseProtocol {
    
    /// 장소 상세 화면 API
    func executeGetPlaceDetail(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError>
}
