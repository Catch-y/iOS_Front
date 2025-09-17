//
//  VoteUsecase.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/8/25.
//

import Foundation
import Moya
import Combine

class VoteUseCase: VoteUseCaseProtocol {
    private let service: VoteServiceProtocol
    
    init(servicee: VoteServiceProtocol = VoteService()) {
        self.service = servicee
    }
    
    /// 투표 생성
    func executePostGenerate(id: VoteGenerateRquest) -> AnyPublisher<ResponseData<VoteGenerateResponse>, Moya.MoyaError> {
        service.postGenerate(id: id)
    }
    
    /// 투표 진행 중 - 카테고리 ID 목록 조회
    func executeGetProgressIn(path: VoteInProgressPath) -> AnyPublisher<ResponseData<VoteInProgressResponse>, Moya.MoyaError> {
        service.getProgressIn(path: path)
    }
    
    /// 카테고리 투표
    func executePostCategory(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.postCategory(path: path, category: category)
    }
    
    
    /// 카테고리 재투표
    func executePostRevote(path: VoteCategoryPath, category: VoteCategoryRequest) -> AnyPublisher<ResponseData<EmptyResponse>, Moya.MoyaError> {
        service.postRevote(path: path, category: category)
    }
    
    /// 장소 투표/취소
    func executePatchPlace(path: VoteLocationTogglePath, id: VoteLocationToggleRequet) -> AnyPublisher<ResponseData<String>, Moya.MoyaError> {
        service.patchPlace(path: path, id: id)
    }
    
    /// 투표 진행 중 - 카테고리 투표 현황 조회
    func executeGetCategoryProgressIn(path: VoteStatusPath) -> AnyPublisher<ResponseData<VoteStatusResponse>, Moya.MoyaError> {
        service.getCategoryProgressIn(path: path)
    }
    
    /// 투표 완료- 카테고리 확인
    func executeGetCompleteVote(path: VoteCompletePath) -> AnyPublisher<ResponseData<VoteCompleteResponse>, Moya.MoyaError> {
        service.getCompleteVote(path: path)
    }
    
    /// 투표 진행 중 - 멤버 별 투표 현황 조회
    func executeGetMember(path: VoteMemeberInProgressPath) -> AnyPublisher<ResponseData<VoteMemeberInProgressResponse>, Moya.MoyaError> {
        service.getMember(path: path)
    }
    
    /// 투표 완료 - 카테고리 별 장소 확인
    func executeGetCategroyPlace(path: VoteCategoryPlacePath, query: VoteCategoryPlaceQuery) -> AnyPublisher<ResponseData<VoteCategoryPlaceResponse>, Moya.MoyaError> {
        service.getCategroyPlace(path: path, query: query)
    }
    
}
