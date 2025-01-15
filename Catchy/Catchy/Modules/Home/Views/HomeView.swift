//
//  HomeView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        topTitle
    }
    
    private var topTitle: some View {
        Text(DataFormatter.shared.makeStyledText(for: "\(UserState.shared.getUserNickname())님의 취향을 저격할 \n코스를 알려드릴게요!"))
            .multilineTextAlignment(.leading)
            .font(.Subtitle2)
            .foregroundStyle(Color.g7)
            .lineSpacing(3)
    }
    
    
}

#Preview {
    HomeView()
}
