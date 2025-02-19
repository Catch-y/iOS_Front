//
//  VoteRepository.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation
import Combine
import Moya

/// [투표 관리] Repository 구현체
class VoteRepository: VoteRepositoryProtocol {
    
    let provider: VoteServiceProtocol
    
    init(provider: VoteServiceProtocol = VoteService()) {
        self.provider = provider
    }
    
    func postCreateVote(createVoteRequest: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, MoyaError> {
        return provider.postCreateVote(createVoteRequest: createVoteRequest)
    }
    
    func getVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError> {
        return provider.getVoteInProgress(voteId: voteId)
    }
    
    func postCategoryVote(voteId: Int, categoryVoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return provider.postCategoryVote(voteId: voteId, categoryVoteRequest: categoryVoteRequest)
    }
    
    func postCategoryRevote(voteId: Int, revoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return provider.postCategoryRevote(voteId: voteId, revoteRequest: revoteRequest)
    }
    
    func patchPlaceVote(groupId: Int, voteId: Int, placeVoteRequest: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError> {
        return provider.patchPlaceVote(groupId: groupId, voteId: voteId, placeVoteRequest: placeVoteRequest)
    }
    
    func getVoteStatus(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError> {
        return provider.getVoteStatus(voteId: voteId)
    }
    
    func getVoteResults(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, MoyaError> {
        return provider.getVoteResults(groupId: groupId, voteId: voteId)
    }
    
    func getVoteMembers(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<[VoteMemberResponse]>, MoyaError> {
        return provider.getVoteMembers(groupId: groupId, voteId: voteId)
    }
    
    func getCategoryPlaces(groupId: Int, category: String) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError> {
        return provider.getCategoryPlaces(groupId: groupId, category: category)
    }
}
