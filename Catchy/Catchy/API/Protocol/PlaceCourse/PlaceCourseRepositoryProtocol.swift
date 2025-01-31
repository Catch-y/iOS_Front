//
//  PlaceCourseRepositoryProtocol.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

/// [PlaceCourse] RepositoryProtocol
protocol PlaceCourseRepositoryProtocol {
    
    /// 장소 상세 화면 API
    func getPlaceDetailData(placeId: Int) -> AnyPublisher<ResponseData<PlaceDetailResponse>, MoyaError>
    
}
