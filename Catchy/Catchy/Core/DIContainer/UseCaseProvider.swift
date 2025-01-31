//
//  UseCaseProtocol.swift
//  Catchy
//
//  Created by 정의찬 on 1/13/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCase { get set }
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase { get set }
    
    /// [투표 생성] UseCase
    var creatingVoteUseCase: CreatingVoteUseCase { get set }
    
    /// [투표 카테고리] UseCase
    var categoryVoteUseCase: CategoryVoteUseCase { get set }
    /// [장소 투표] UseCase
    var placeVoteUseCase: PlaceVoteUseCase { get set }
    /// [투표진행중일때 투표현황 조회] UseCase
    var voteInProgressUseCase : VoteInProgressUseCase { get set }
    /// [투표결과 - 카테고리] UseCase
    var voteResultCategoryUseCase : VoteResultCategoryUseCase{ get set }
    /// [투표결과 - 카테고리별 장소] UseCase
    var voteResultPlaceUseCase : VoteResultPlaceUseCase{ get set }
}

class UseCaseProvider: UseCaseProtocol {
    
    
    var authUseCase: AuthUseCase
    
    /// [코스 관리] UseCase
    var courseManagementUseCase: CourseManagementUseCase
    
    
    ///[투표중인 멤버 관리] UseCase
    var votingMemberUseCase: VotingMemberUseCase
    
    ///[투표 생성] UseCase
    var creatingVoteUseCase: CreatingVoteUseCase
    ///[투표 카테고리] UseCase
    var categoryVoteUseCase: CategoryVoteUseCase
    /// [장소 투표] UseCase
    var placeVoteUseCase: PlaceVoteUseCase
    /// [투표진행중일때 투표현황 조회] UseCase
    var voteInProgressUseCase : VoteInProgressUseCase
    /// [카테고리투표결과] UseCase
    var voteResultCategoryUseCase : VoteResultCategoryUseCase
    /// [투표결과 - 카테고리별 장소] UseCase
    var voteResultPlaceUseCase : VoteResultPlaceUseCase
    
    
    init() {
        self.authUseCase = AuthUseCase()
        self.courseManagementUseCase = CourseManagementUseCase()
        self.votingMemberUseCase = VotingMemberUseCase()
        self.creatingVoteUseCase = CreatingVoteUseCase()
        self.categoryVoteUseCase = CategoryVoteUseCase()
        self.placeVoteUseCase = PlaceVoteUseCase()
        self.voteInProgressUseCase = VoteInProgressUseCase()
        self.voteResultCategoryUseCase = VoteResultCategoryUseCase()
        self.voteResultPlaceUseCase = VoteResultPlaceUseCase()
    }
    
    
}
