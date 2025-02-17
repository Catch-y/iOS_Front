//
//  MainProgressComponents.swift
//  Catchy
//
//  Created by 정의찬 on 2/14/25.
//

import SwiftUI

struct MainProgressComponents: View {
    
    let text: String
    
    init(text: String = "로딩중입니다.") {
        self.text = text
    }
    
    
    var body: some View {
        Spacer()
        
        ProgressView(label: {
            Text(text)
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
