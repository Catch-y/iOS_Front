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
        case .SignUpView(let signUpNaviData):
            SignUpView(container: container, appFlowViewModel: appFlowViewModel, signUpNaviData: signUpNaviData)
        }
    }
}
