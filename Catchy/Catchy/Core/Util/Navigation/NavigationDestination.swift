//
//  SwiftAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation

enum NavigationDestination: Equatable, Hashable {
    case signUpView(signUpNaviData: SignUpNaviData)
    case searchView
    case similarView /* 비슷한 취향을 가진 장소 보기 */
    case courseDetailView(courseId: Int) /* 코스 상세화면 보기 */
    case groupVoteStartView /* 투표 참여 화면 추가 */
    case locationSelectView /* 지역 선택 뷰 화면 */
    case createGroupView  /* 그룹 만들기 뷰 */
    case groupVoteView(groupId: Int) /* 그룹 투표 시작 페이지 */
    case mypageOption
    case favoritePlacesView
    case fullScreenMap(viewModel: AppleMapViewModel)
    case placeReviewRegisterView(placeId: Int)
    case myReviewsView
    case diyCourseCreateView(placeIds: [Int]) /* 코스 생성하기 */
    case placeReviewView(placeId: Int) /* 장소 평점, 리뷰 보기*/
}
    
    // Equatable 구현 (fullScreenMap 비교 제외)
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.signUpView(let lData), .signUpView(let rData)):
            return lData == rData
        case (.searchView, .searchView),
             (.similarView, .similarView),
             (.mypageOption, .mypageOption),
             (.favoritePlacesView, .favoritePlacesView),
             (.myReviewsView, .myReviewsView),
             (.groupVoteStartView, .groupVoteStartView),
             (.locationSelectView, .locationSelectView),
             (.createGroupView, .createGroupView):
            return true
        case (.courseDetailView(let lId), .courseDetailView(let rId)):
            return lId == rId
        case (.placeReviewRegisterView(let lId), .placeReviewRegisterView(let rId)):
            return lId == rId
        case (.groupVoteView(let lId), .groupVoteView(let rId)):
            return lId == rId
        case (.fullScreenMap, .fullScreenMap):
            return false // `fullScreenMap` 비교 제외
        default:
            return false
        }
    }
    
    // Hashable 구현 (`fullScreenMap` 제외)
    func hash(into hasher: inout Hasher) {
        switch self {
        case .signUpView(let data):
            hasher.combine("signUpView")
            hasher.combine(data)
        case .searchView:
            hasher.combine("searchView")
        case .similarView:
            hasher.combine("similarView")
        case .courseDetailView(let courseId):
            hasher.combine("courseDetailView")
            hasher.combine(courseId)
        case .mypageOption:
            hasher.combine("mypageOption")
        case .favoritePlacesView:
            hasher.combine("favoritePlacesView")
        case .placeReviewRegisterView(let placeId):
            hasher.combine("placeReviewRegisterView")
            hasher.combine(placeId)
        case .myReviewsView:
            hasher.combine("myReviewsView")
        case .groupVoteStartView:
            hasher.combine("groupVoteStartView")
        case .locationSelectView:
            hasher.combine("locationSelectView")
        case .createGroupView:
            hasher.combine("createGroupView")
        case .groupVoteView(let groupId):
            hasher.combine("groupVoteView")
            hasher.combine(groupId)
        case .fullScreenMap:
            hasher.combine("fullScreenMap")
        }
    }
}
