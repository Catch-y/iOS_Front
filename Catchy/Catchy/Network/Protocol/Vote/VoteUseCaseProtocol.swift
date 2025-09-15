//
//  VoteUseCase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/8/25.
//

import Foundation
import Combine
import Moya

protocol VoteUseCaseProtocol {
    func executePostGenerate(id: VoteGenerateRquest) -> AnyPublisher<ResponseData<VoteGenerateResponse>, MoyaError>
    func executeGetProgressIn(path: VoteInProgressPath) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError>
    func executePostCategory(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    func executePostRevote(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    func executePatchPlace(path: VoteLocationTogglePath, id: VoteLocationToggleRequet) -> AnyPublisher<ResponseData<String>, MoyaError>
    func executeGetCategoryProgressIn(path: VoteStatusPath) -> AnyPublisher<ResponseData<VoteStatusResponse>, MoyaError>
    func executeGetCompleteVote(path: VoteCompletePath) -> AnyPublisher<ResponseData<VoteCompleteResponse>, MoyaError>
    func executeGetMember(path: VoteMemeberInProgressPath) -> AnyPublisher<ResponseData<VoteMemeberInProgressResponse>, MoyaError>
    func executeGetCategroyPlace(path: VoteCategoryPlacePath, query: VoteCategoryPlaceQuery) -> AnyPublisher<ResponseData<VoteCategoryPlaceResponse>, MoyaError>
}
