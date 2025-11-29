//
//  PlacePoint.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/26/25.
//

import SwiftUI

struct PlaceLabel: View {
    
    // MARK: - Property
    let image: Image
    let text: String
    let labelSpacing: CGFloat
    
    private enum LabelSpacing {
        case review(spacing: CGFloat = 6)
        case etc(spacing: CGFloat)
    }
    
    // MARK: - Body
    var body: some View {
        Label(title: {
            generateInfoText(text)
        }, icon: {
            image
                .fixedSize()
        })
        .labelIconToTitleSpacing(labelSpacing)
    }
    
    private func generateInfoText(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.g4)
    }
}

#Preview {
    PlaceLabel(image: Image(.star), text: "평점 4.3", labelSpacing: 5)
}
