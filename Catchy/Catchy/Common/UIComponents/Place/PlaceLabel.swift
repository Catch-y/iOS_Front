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
        })
        .labelIconToTitleSpacing(labelSpacing)
        .labelStyle(.titleAndIcon)
    }
    
    private func generateInfoText(_ text: String) -> some View {
        Text(text.customLineBreak())
            .font(.caption)
            .foregroundStyle(.g4)
    }
}

struct RatingPoint: View {
    let point: String
    
    var body: some View {
        PlaceLabel(image: Image(.star), text: "평점 \(point)", labelSpacing: 2)
    }
}

struct ReviewPoint: View {
    
    let point: String
    let id: Int
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        Button(action: {
            // TODO: - Navi 연결
            print("hello")
        }, label: {
            HStack(spacing: 6, content: {
                PlaceLabel(image: Image(.review), text: "리뷰 \(point)개", labelSpacing: 2)
                Image(.rightChevron)
            })
            .underline(color: .g4)
        })
    }
}

struct RoadAddress: View {
    let text: String
    
    var body: some View {
        PlaceLabel(image: Image(.location), text: text, labelSpacing: 1)
    }
}

struct OperatingTime: View {
    let text: String
    
    var body: some View {
        PlaceLabel(image: Image(.time), text: text, labelSpacing: 1)
    }
}
