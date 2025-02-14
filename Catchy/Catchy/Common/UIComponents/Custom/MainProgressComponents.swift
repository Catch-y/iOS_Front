//
//  MainProgressComponents.swift
//  Catchy
//
//  Created by 정의찬 on 2/14/25.
//

import SwiftUI

struct MainProgressComponents: View {
    var body: some View {
        Spacer()
        
        ProgressView(label: {
            Text("로딩중입니다.")
                .font(.body3)
                .foregroundStyle(Color.g7)
        })
        .controlSize(.regular)
        .tint(Color.main)
        
        Spacer()
    }
}

#Preview {
    MainProgressComponents()
}
