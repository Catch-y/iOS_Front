//
//  PlaceService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/17/25.
//

import Foundation
import Moya
import Combine

class PlaceService: PlaceServiceProtocol, BaseAPIService {
    
    typealias Target = PlaceRouter
    
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
    
    func postReview(path: PlaceReviewPath, place: PlaceReviewRequest) -> AnyPublisher<ResponseData<PlaceReviewResponse>, Moya.MoyaError> {
        request(.postReview(path: path, place: place))
    }
    
    func pathLike(path: PlaceLikePath) -> AnyPublisher<ResponseData<PlaceLikeResponse>, Moya.MoyaError> {
        request(.pathLike(path: path))
    }
    
    func getPlaceReview(path: PlaceAllReviewPath, query: PlaceAllReviewQuery) -> AnyPublisher<ResponseData<PlaceAllReviewResponse>, Moya.MoyaError> {
        request(.getPlaceReview(path: path, query: query))
    }
    
    func getPlaceVisit(path: PlaceVisitListPath) -> AnyPublisher<ResponseData<PlaceVisitListResponse>, Moya.MoyaError> {
        request(.getPlaceVisit(path: path))
    }
    
    func getPlaceSearch(query: PlaceSearchQuery) -> AnyPublisher<ResponseData<PlaceSearchResponse>, Moya.MoyaError> {
        request(.getPlaceSearch(query: query))
    }
    
    func getPlaceRecommend(query: PlaceRecommendQuery) -> AnyPublisher<ResponseData<PlaceRecommendResponse>, Moya.MoyaError> {
        request(.getPlaceRecommend(query: query))
    }
}
