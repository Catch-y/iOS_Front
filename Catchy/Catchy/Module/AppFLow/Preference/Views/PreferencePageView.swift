//
//  PreferencePageView.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/9/25.
//

import SwiftUI

struct PreferencePageView: View {
    
    // MARK: - Property
    @State var viewModel: PreferenceViewModel
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Init
    init(container: DIContainer, appFlow: AppFlow) {
        self.viewModel = .init(container: container, appFlow: appFlow)
    }
    
    var body: some View {
        switch viewModel.preferencPage {
        case .one:
            FirstPage(viewModel: viewModel)
        case .two:
            SecondPage(viewModel: viewModel)
        case .three:
            ThirdPage(viewModel: viewModel)
        case .four:
            FourthPage(viewModel: viewModel, container: container)
        }
    }
}

#Preview {
    PreferencePageView(container: DIContainer(), appFlow: AppFlow())
        .environmentObject(DIContainer())
}
