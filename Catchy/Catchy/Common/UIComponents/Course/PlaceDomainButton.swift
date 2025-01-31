//
//  PlaceDomainButton.swift
//  Catchy
//
//  Created by LEE on 1/28/25.
//

import SwiftUI

/// 장소의 도메인 텍스트 버튼 
struct PlaceDomainButton: View {
    
    let domain: String
    
    var body: some View {
        HStack(spacing: 5) {
            Icon.domain.image
                .resizable()
                .frame(width: 12, height: 12)
            
            Text(domain)
                .underline(true, color: .black)
                .lineLimit(1)
                .foregroundStyle(.g5)
                .font(.caption)
        }
    }
    
    init(domain: String) {
        self.domain = domain
    }
}
