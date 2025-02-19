//
//  VoteService.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation
import Combine
import Moya

/// [투표 관리] Service 구현체
class VoteService: VoteServiceProtocol {
    
    let provider = MoyaProvider<VoteAPITarget>()
    
    func postCreateVote(createVoteRequest: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, MoyaError> {
        return provider.requestPublisher(.postCreateVote(createVoteRequest: createVoteRequest))
            .map(ResponseData<CreateVoteResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError> {
        return provider.requestPublisher(.getVoteInProgress(voteId: voteId))
            .map(ResponseData<VoteInProgressResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func postCategoryVote(voteId: Int, categoryVoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return provider.requestPublisher(.postCategoryVote(voteId: voteId, categoryVoteRequest: categoryVoteRequest))
            .map(ResponseData<VoteCategoryResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func postCategoryRevote(voteId: Int, revoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return provider.requestPublisher(.postCategoryRevote(voteId: voteId, revoteRequest: revoteRequest))
            .map(ResponseData<VoteCategoryResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func patchPlaceVote(groupId: Int, voteId: Int, placeVoteRequest: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError> {
        return provider.requestPublisher(.patchPlaceVote(groupId: groupId, voteId: voteId, placeVoteRequest: placeVoteRequest))
            .map(ResponseData<PlaceVoteResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getVoteStatus(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError> {
        return provider.requestPublisher(.getVoteStatus(voteId: voteId))
            .map(ResponseData<VoteInProgressResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getVoteResults(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, MoyaError> {
        return provider.requestPublisher(.getVoteResults(groupId: groupId, voteId: voteId))
            .map(ResponseData<VoteResultCategoryResponse>.self)
            .eraseToAnyPublisher()
    }
    
    func getVoteMembers(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<[VoteMemberResponse]>, MoyaError> {
        return provider.requestPublisher(.getVoteMembers(groupId: groupId, voteId: voteId))
            .map(ResponseData<[VoteMemberResponse]>.self)
            .eraseToAnyPublisher()
    }
    
    func getCategoryPlaces(groupId: Int, category: String) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError> {
        return provider.requestPublisher(.getCategoryPlaces(groupId: groupId, category: category))
            .map(ResponseData<VoteResultPlaceResponse>.self)
            .eraseToAnyPublisher()
    }
}
