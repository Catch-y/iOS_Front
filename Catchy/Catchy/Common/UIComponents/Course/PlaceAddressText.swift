//
//  PlaceAddressText.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI

/// 장소 이름 텍스트
struct PlaceAddressText: View {
    
    let addressText: String
    
    init(addressText: String) {
        self.addressText = addressText
    }
    var body: some View {
        HStack(spacing: 5) {
            Icon.location.image.resizable()
                .frame(width: 12, height: 12)
            
            Text(addressText)
                .font(.caption)
                .foregroundStyle(.g5)
                .lineLimit(1)
        }
    }
}
