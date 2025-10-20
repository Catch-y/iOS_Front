//
//  NavigationRoutingView.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation
import SwiftUI

struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @Environment(\.appFlow) var appFlow: AppFlow
    
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .test:
            Text("!1")
        }
    }
}
