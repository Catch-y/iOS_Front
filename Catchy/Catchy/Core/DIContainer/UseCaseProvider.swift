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
    /// [그룹생성] UseCase
    var createGroupUsecase : CreateGroupUseCase { get set }
    /// [그룹 초대코드] UseCase
    var groupJoinUseCase: GroupJoinUseCase { get set }
    /// [그룹 멤버 조회] UseCase
    var groupMembersUseCase: GroupMembersUseCase { get set }
    /// [내 그룹 조회] UseCase
    var myGroupsUseCase: MyGroupsUseCase { get set }
    /// [초대 코드로 그룹정보 조회] UseCase
    var groupInviteUseCase: GroupInviteUseCase { get set }
    /// [그룹탈퇴] UseCase
    var groupLeaveUseCase: GroupLeaveUseCase { get set }
    
    
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
    /// [그룹생성] UseCase
    var createGroupUsecase : CreateGroupUseCase
    /// [그룹초대코드] UseCase
    var groupJoinUseCase: GroupJoinUseCase
    /// [그룹멤버조회] UseCase
    var groupMembersUseCase: GroupMembersUseCase
    /// [내 그룹 조회] UseCase
    var myGroupsUseCase: MyGroupsUseCase
    /// [초대 코드로 그룹정보 조회] UseCase
    var groupInviteUseCase: GroupInviteUseCase
    /// [그룹탈퇴] UseCase
    var groupLeaveUseCase: GroupLeaveUseCase
    
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
        self.createGroupUsecase = CreateGroupUseCase()
        self.groupJoinUseCase = GroupJoinUseCase()
        self.groupMembersUseCase = GroupMembersUseCase()
        self.myGroupsUseCase = MyGroupsUseCase()
        self.groupInviteUseCase = GroupInviteUseCase()
        self.groupLeaveUseCase = GroupLeaveUseCase()
                
    }
    
    
}
