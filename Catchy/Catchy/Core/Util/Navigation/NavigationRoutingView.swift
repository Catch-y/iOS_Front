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
            
        case .mypageOption:
            SettingView(container: container, appFlowViewModel: appFlowViewModel)
                .environmentObject(container)
        case .favoritePlacesView:
            FavoritePlacesView(container: container)
                .environmentObject(container)
        case .myReviewsView:
            MyReviewsView(container: container)
                .environmentObject(container)
            
        case .placeReviewRegsiterView(let placeId):
            PlaceReviewRegisterView(container: container, placeId: placeId)
                .environmentObject(container)
            
        case .diyCourseCreateView(let placeIds):
            DIYCourseCreateView(container: container, placeIds: placeIds)
                .environmentObject(container)
            
        case .placeReviewView(let placeId):
            PlaceReviewView(container: container, placeId: placeId)
                .environmentObject(container)
        }
    }
}
