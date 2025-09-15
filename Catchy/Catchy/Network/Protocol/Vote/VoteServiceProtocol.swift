//
//  VoteService.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/8/25.
//

import Foundation
import Combine
import Moya

protocol VoteServiceProtocol {
    func postGenerate(id: VoteGenerateRquest) -> AnyPublisher<ResponseData<VoteGenerateResponse>, MoyaError>
    func getProgressIn(path: VoteInProgressPath) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError>
    func postCategory(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    func postRevote(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    func patchPlace(path: VoteLocationTogglePath, id: VoteLocationToggleRequet) -> AnyPublisher<ResponseData<String>, MoyaError>
    func getCategoryProgressIn(path: VoteStatusPath) -> AnyPublisher<ResponseData<VoteStatusResponse>, MoyaError>
    func getCompleteVote(path: VoteCompletePath) -> AnyPublisher<ResponseData<VoteCompleteResponse>, MoyaError>
    func getMember(path: VoteMemeberInProgressPath) -> AnyPublisher<ResponseData<VoteMemeberInProgressResponse>, MoyaError>
    func getCategroyPlace(path: VoteCategoryPlacePath, query: VoteCategoryPlaceQuery) -> AnyPublisher<ResponseData<VoteCategoryPlaceResponse>, MoyaError>
}
