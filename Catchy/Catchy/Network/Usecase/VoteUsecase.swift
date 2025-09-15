//
//  VoteUsecase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/8/25.
//

import Foundation
import Moya
import Combine

class VoteUsecase: VoteUseCaseProtocol {
    private let service: VoteServiceProtocol
    
    init(servicee: VoteServiceProtocol = VoteService()) {
        self.service = servicee
    }
    
    func executePostGenerate(id: VoteGenerateRquest) -> AnyPublisher<ResponseData<VoteGenerateResponse>, Moya.MoyaError> {
        service.postGenerate(id: id)
    }
    
    func executeGetProgressIn(path: VoteInProgressPath) -> AnyPublisher<ResponseData<VoteInProgressResponse>, Moya.MoyaError> {
        service.getProgressIn(path: path)
    }
    
    func executePostCategory(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.postCategory(path: path, category: category)
    }
    
    func executePostRevote(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.postRevote(path: path, category: category)
    }
    
    func executePatchPlace(path: VoteLocationTogglePath, id: VoteLocationToggleRequet) -> AnyPublisher<ResponseData<String>, Moya.MoyaError> {
        service.patchPlace(path: path, id: id)
    }
    
    func executeGetCategoryProgressIn(path: VoteStatusPath) -> AnyPublisher<ResponseData<VoteStatusResponse>, Moya.MoyaError> {
        service.getCategoryProgressIn(path: path)
    }
    
    func executeGetCompleteVote(path: VoteCompletePath) -> AnyPublisher<ResponseData<VoteCompleteResponse>, Moya.MoyaError> {
        service.getCompleteVote(path: path)
    }
    
    func executeGetMember(path: VoteMemeberInProgressPath) -> AnyPublisher<ResponseData<VoteMemeberInProgressResponse>, Moya.MoyaError> {
        service.getMember(path: path)
    }
    
    func executeGetCategroyPlace(path: VoteCategoryPlacePath, query: VoteCategoryPlaceQuery) -> AnyPublisher<ResponseData<VoteCategoryPlaceResponse>, Moya.MoyaError> {
        service.getCategroyPlace(path: path, query: query)
    }
    
}
