//
//  VoteUseCase.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation
import Combine
import Moya

/// [투표 관리] UseCase 구현체
class VoteUseCase: VoteUseCaseProtocol {
    
    let repository: VoteRepositoryProtocol
    
    init(repository: VoteRepositoryProtocol = VoteRepository()) {
        self.repository = repository
    }
    
    func executePostCreateVote(createVoteRequest: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, MoyaError> {
        return repository.postCreateVote(createVoteRequest: createVoteRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError> {
        return repository.getVoteInProgress(voteId: voteId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePostCategoryVote(voteId: Int, categoryVoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return repository.postCategoryVote(voteId: voteId, categoryVoteRequest: categoryVoteRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePostCategoryRevote(voteId: Int, revoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError> {
        return repository.postCategoryRevote(voteId: voteId, revoteRequest: revoteRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executePatchPlaceVote(groupId: Int, voteId: Int, placeVoteRequest: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError> {
        return repository.patchPlaceVote(groupId: groupId, voteId: voteId, placeVoteRequest: placeVoteRequest)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetVoteStatus(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError> {
        return repository.getVoteStatus(voteId: voteId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetVoteResults(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, MoyaError> {
        return repository.getVoteResults(groupId: groupId, voteId: voteId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetVoteMembers(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<[VoteMemberResponse]>, MoyaError> {
        return repository.getVoteMembers(groupId: groupId, voteId: voteId)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
    
    func executeGetCategoryPlaces(groupId: Int, category: String) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError> {
        return repository.getCategoryPlaces(groupId: groupId, category: category)
            .mapError { $0 as MoyaError }
            .eraseToAnyPublisher()
    }
}

