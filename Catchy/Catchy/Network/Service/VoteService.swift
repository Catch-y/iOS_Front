//
//  VoteService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/8/25.
//

import Foundation
import Combine
import Moya

class VoteService: VoteServiceProtocol, BaseAPIService {
    typealias Target = VoteRouter
    
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
    
    func postGenerate(id: VoteGenerateRquest) -> AnyPublisher<ResponseData<VoteGenerateResponse>, Moya.MoyaError> {
        request(.postGenerate(id: id))
    }
    
    func getProgressIn(path: VoteInProgressPath) -> AnyPublisher<ResponseData<VoteInProgressResponse>, Moya.MoyaError> {
        request(.getProgressIn(path: path))
    }
    
    func postCategory(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.postCategory(path: path, category: category))
    }
    
    func postRevote(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        request(.postRevote(path: path, category: category))
    }
    
    func patchPlace(path: VoteLocationTogglePath, id: VoteLocationToggleRequet) -> AnyPublisher<ResponseData<String>, Moya.MoyaError> {
        request(.patchPlace(path: path, id: id))
    }
    
    func getCategoryProgressIn(path: VoteStatusPath) -> AnyPublisher<ResponseData<VoteStatusResponse>, Moya.MoyaError> {
        request(.getCategoryProgressIn(path: path))
    }
    
    func getCompleteVote(path: VoteCompletePath) -> AnyPublisher<ResponseData<VoteCompleteResponse>, Moya.MoyaError> {
        request(.getCompleteVote(path: path))
    }
    
    func getMember(path: VoteMemeberInProgressPath) -> AnyPublisher<ResponseData<VoteMemeberInProgressResponse>, Moya.MoyaError> {
        request(.getMember(path: path))
    }
    
    func getCategroyPlace(path: VoteCategoryPlacePath, query: VoteCategoryPlaceQuery) -> AnyPublisher<ResponseData<VoteCategoryPlaceResponse>, Moya.MoyaError> {
        request(.getCategroyPlace(path: path, query: query))
    }
    
}
