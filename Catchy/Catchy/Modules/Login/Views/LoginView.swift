//
//  LoginView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        VStack(alignment: .leading, content: {
            topLogoGroup
            
            Spacer()
            
            bottomBtnGroup
        })
        .safeAreaPadding(EdgeInsets(top: 178, leading: 0, bottom: 98, trailing: 0))
    }
    
    private var topLogoGroup: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Icon.appIcon.image
                .fixedSize()
            
            Icon.logo.image
                .resizable()
                .frame(width: 138, height: 50)
                .aspectRatio(contentMode: .fit)
                .padding(.top, 5)
            
            Text("특별한 하루를 위해 \n취향을 catch:y")
                .font(.body1)
                .lineSpacing(2.5)
                .foregroundStyle(Color.g4)
                .multilineTextAlignment(.leading)
                .padding(.leading, 5)
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

#Preview {
    LoginView()
}
