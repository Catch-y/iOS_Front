//
//  PlaceCourseService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Combine
import Moya

class PlaceCourseService: PlaceCourseServiceProtocol, BaseAPIService {
    typealias Target = PlaceCourseRouter
    
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
    
    func getDetailPlace(path: PlaceCourseDetailPath) -> AnyPublisher<ResponseData<PlaceCourseDetailResponse>, Moya.MoyaError> {
        request(.getDetailPlace(path: path))
    }
    
    func getSearchPlace(query: PlaceCourseSearchQuery) -> AnyPublisher<ResponseData<PlaceCourseSearchResponse>, Moya.MoyaError> {
        request(.getSearchPlace(query: query))
    }
    
    func getLikeScroll(query: PlaceCourseLikeQuery) -> AnyPublisher<ResponseData<PlaceCourseLikeResponse>, Moya.MoyaError> {
        request(.getLikeScroll(query: query))
    }
    
    func getCurrentLocation(query: PlaceCourseCurrentSearchQuery) -> AnyPublisher<ResponseData<PlaceCourseSearchResponse>, Moya.MoyaError> {
        request(.getCurrentLocation(query: query))
    }
}
