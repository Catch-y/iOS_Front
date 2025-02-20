//
//  NavigationRoutingView.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import SwiftUI

struct NavigationRoutingView: View {
    
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .signUpView(let signUpNaviData):
            SignUpView(container: container, appFlowViewModel: appFlowViewModel, signUpNaviData: signUpNaviData)
                .environmentObject(container)
          
        case .searchView:
            SearchView(container: container)
          
        case .similarView:
            SimilarPlacesView(container: container)
                .environmentObject(container)
          
        case .courseDetailView(let courseId):
            CourseDetailView(container: container, courseId: courseId)
                .environmentObject(container)
           
        case .groupVoteStartView:
            GroupVoteStartView(container: container)
                .environmentObject(container)
            
        case .locationSelectView: 
                   LocationSelectView(container: container)
                       .environmentObject(container)
            
        case .createGroupView:
            let calendarViewModel = CalenderViewModel(container: container)
            CreateGroupView(container: container, calendarViewModel: calendarViewModel) 
                .environmentObject(container)

          
        case .groupVoteView(let groupId):
            GroupVoteView(container: container, groupId: groupId)
                        .environmentObject(container)
          
        case .mypageOption:
            SettingView(container: container, appFlowViewModel: appFlowViewModel)
                .environmentObject(container)
          
        case .favoritePlacesView:
            FavoritePlacesView(container: container)
                .environmentObject(container)
          
        case .fullScreenMap(let viewModel):
            FullScreenMap(viewModel: viewModel)
          
        case .myReviewsView:
            MyReviewsView(container: container)
                .environmentObject(container)
        case .placeReviewRegisterView(let placeId):
            PlaceReviewRegisterView(container: container, placeId: placeId)
                .environmentObject(container)
            
        case .diyCourseCreateView(let placeIds):
            DIYCourseCreateView(container: container, placeIds: placeIds)
                .environmentObject(container)
            
        case .placeReviewView(let placeId):
            PlaceReviewView(container: container, placeId: placeId)
                .environmentObject(container)        
        case .voteDoneView:
            VoteDoneView()
                .environmentObject(container)
        
        case .voteDoneCategoryView(let groupId, let voteId): 
            VoteDoneCategoryView(container: container, groupId: groupId, voteId: voteId)
                    .environmentObject(container)
            
        case .voteResultPlaceView(let groupId, let category): 
            VoteResultPlaceView(viewModel: VoteResultCategoryCardViewModel(groupId: groupId, category: category))
                    .environmentObject(container)
        case .qrCodeInviteView:
                   QRCodeInviteView(container: container)
                           .environmentObject(container)
        case .placeDetailView(let viewModel, let placeSearchResponseData):
            PlaceDetailView(viewModel: viewModel, placeSearchResponseData: placeSearchResponseData)
            
        case .placeBucketView(let viewModel):
            PlaceBucketView(viewModel: viewModel)
        case .diyMap:
            DIYMap(container: container)
                .environmentObject(container)
        }
    }
}
