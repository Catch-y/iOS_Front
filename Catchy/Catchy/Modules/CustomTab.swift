//
//  CustomTab.swift
//  Catchy
//
//  Created by 정의찬 on 2/10/25.
//

import SwiftUI

struct CustomTab: View {
    
    @Binding var selectedTab: TabCase
    
    var body: some View {
        HStack {
            ForEach(TabCase.allCases, id: \.rawValue) { tab in
                
                Spacer()
                
                makeTabButton(tab)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .ignoresSafeArea(.keyboard)
        .background(Color.white)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: -5)
    }
    
    private func makeTabButton(_ tab: TabCase) -> Button<some View> {
        return Button(action: {
            withAnimation {
                selectedTab = tab
            }
        }, label: {
            VStack(spacing: 8, content: {
                Icon(rawValue: tab.rawValue)?.image
                    .renderingMode(.template)
                    .fixedSize()
                    .foregroundStyle(selectedTab == tab ? Color.main : Color.g3)
                
                Text(tab.toKorean())
                    .font(.caption2)
                    .foregroundStyle(selectedTab == tab ? Color.main : Color.g3)
            })
            .padding(.bottom, 10)
        })
    }
}
