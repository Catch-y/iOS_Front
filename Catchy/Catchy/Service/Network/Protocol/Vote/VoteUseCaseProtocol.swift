//
//  VoteUseCaseProtocol.swift
//  Catchy
//
//  Created by 임소은 on 2/14/25.
//

import Foundation
import Combine
import Moya

/// [투표 관리] UseCase Protocol
protocol VoteUseCaseProtocol {
    
    /// 투표 생성
    func executePostCreateVote(createVoteRequest: CreateVoteRequest) -> AnyPublisher<ResponseData<CreateVoteResponse>, MoyaError>
    
    /// 투표 진행 중 조회
    func executeGetVoteInProgress(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError>
    
    /// 카테고리 투표
    func executePostCategoryVote(voteId: Int, categoryVoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError>
    
    /// 카테고리 재투표
    func executePostCategoryRevote(voteId: Int, revoteRequest: VoteCategoryRequest) -> AnyPublisher<ResponseData<VoteCategoryResponse>, MoyaError>
    
    /// 장소 투표/취소
    func executePatchPlaceVote(groupId: Int, voteId: Int, placeVoteRequest: PlaceVoteRequest) -> AnyPublisher<ResponseData<PlaceVoteResponse>, MoyaError>
    
    /// 투표 진행 중 조회
    func executeGetVoteStatus(voteId: Int) -> AnyPublisher<ResponseData<VoteInProgressResponse>, MoyaError>
    
    /// 투표 완료 - 카테고리 확인
    func executeGetVoteResults(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<VoteResultCategoryResponse>, MoyaError>
    
    /// 투표 진행 중인 멤버 조회
    func executeGetVoteMembers(groupId: Int, voteId: Int) -> AnyPublisher<ResponseData<[VoteMemberResponse]>, MoyaError>
    
    /// 투표 완료 - 카테고리 별 장소 확인
    func executeGetCategoryPlaces(groupId: Int, category: String) -> AnyPublisher<ResponseData<VoteResultPlaceResponse>, MoyaError>
}
