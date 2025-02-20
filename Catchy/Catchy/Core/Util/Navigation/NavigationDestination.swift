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
    case similarView
    case courseDetailView(courseId: Int)
    case groupVoteStartView
    case locationSelectView
    case createGroupView
    case groupVoteView(groupId: Int)
    case mypageOption
    case favoritePlacesView
    case fullScreenMap(viewModel: AppleMapViewModel)
    case placeReviewRegisterView(placeId: Int)
    case myReviewsView
    case diyCourseCreateView(placeIds: [Int])
    case placeReviewView(placeId: Int)
    case voteDoneView
    case voteDoneCategoryView(groupId : Int , voteId : Int)
    case voteResultPlaceView(groupId : Int , category : String)
    

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
             (.createGroupView, .createGroupView),
            (.voteDoneView, .voteDoneView),
            (.voteDoneCategoryView , voteDoneCategoryView):
            
            return true
        case (.courseDetailView(let lId), .courseDetailView(let rId)):
            return lId == rId
        case (.placeReviewRegisterView(let lId), .placeReviewRegisterView(let rId)):
            return lId == rId
        case (.groupVoteView(let lId), .groupVoteView(let rId)):
            return lId == rId
        case (.diyCourseCreateView(let lIds), .diyCourseCreateView(let rIds)):
            return lIds == rIds
        case (.placeReviewView(let lId), .placeReviewView(let rId)):
            return lId == rId
        case (.fullScreenMap, .fullScreenMap):
            return false // `fullScreenMap`은 항상 다르게 취급
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
        case .diyCourseCreateView(let placeIds):
            hasher.combine("diyCourseCreateView")
            hasher.combine(placeIds)
        case .placeReviewView(let placeId):
            hasher.combine("placeReviewView")
            hasher.combine(placeId)
        case .voteDoneView:
            hasher.combine("voteDoneView")
        case .voteDoneCategoryView:
            hasher.combine("voteDoneCategoryView")
        case .voteResultPlaceView(_, _) :
            hasher.combine("voteResultPlaceView")
            
        case .fullScreenMap:
            break // `fullScreenMap`은 해싱하지 않음
        }
    }
}
