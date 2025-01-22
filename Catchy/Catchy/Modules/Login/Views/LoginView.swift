//
//  LoginView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    
    @StateObject var viewModel: LoginViewModel
    
    init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, appflowViewModel: appFlowViewModel))
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            
            topLogoGroup
            
            Spacer()
            
            bottomBtnGroup
        })
        .safeAreaPadding(EdgeInsets(top: 162, leading: 0, bottom: 62, trailing: 0))
    }
    
    private var topLogoGroup: some View {
        VStack(alignment: .leading, spacing: 7, content: {
            Icon.appIcon.image
                .fixedSize()
            
            Icon.logo.image
                .resizable()
                .frame(width: 138, height: 50)
                .aspectRatio(contentMode: .fit)
            
            Text("특별한 하루를 위해 \n취향을 catch:y")
                .font(.Subtitle3)
                .lineSpacing(2.5)
                .foregroundStyle(Color.g6)
                .multilineTextAlignment(.leading)
                .padding(.leading, 9)
        })
        .padding(.leading, 25)
    }
    
    private var bottomBtnGroup: some View {
        VStack(alignment: .center, spacing: 21, content: {
            Icon.kakao.image
                .fixedSize()
            
            Icon.apple.image
                .fixedSize()
        })
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView(container: DIContainer(), appFlowViewModel: AppFlowViewModel())
    }
}
