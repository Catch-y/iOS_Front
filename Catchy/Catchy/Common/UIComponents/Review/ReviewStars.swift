//
//  ReviewStars.swift
//  Catchy
//
//  Created by euijjang97 on 12/19/25.
//

import SwiftUI

struct ReviewStars: View {
    
    // MARK: - Property
    @Binding var rating: Int
    let maxRating: Int = 5
    let size: CGSize
    let spacing: CGFloat
    var onRatingChanged: ((Int) -> Void)?
    
    // MARK: - Init
    init(
        rating: Binding<Int>,
        size: CGSize = CGSize(width: 24, height: 24),
        spacing: CGFloat = 2,
        action: ((Int) -> Void)? = nil
    ) {
        self._rating = rating
        self.size = size
        self.spacing = spacing
        self.onRatingChanged = action
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: spacing, content: {
            ForEach(0..<maxRating, id: \.self) { index in
                starImage(index)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .onTapGesture {
                        updateRating(index + 1)
                    }
            }
        })
        .gesture(
            DragGesture()
                .onChanged { value in
                    calculateRating(location: value.location, width: size.width * CGFloat(maxRating) + spacing * CGFloat(maxRating - 1))
                }
        )
    }
}

// MARK: - Method
extension ReviewStars {
    private func starImage(_ index: Int) -> Image {
        index < rating ? Image(.star) : Image(.emptyStar)
    }
    
    private func updateRating(_ newRating: Int) {
        if rating != newRating {
            rating = newRating
            HapticManager.selection()
            onRatingChanged?(newRating)
        }
    }
    
    private func calculateRating(location: CGPoint, width: CGFloat) {
        let step = width / CGFloat(maxRating)
        let newRating = Int((location.x / step).rounded(.up))
        let clampedRating = min(max(newRating, 0), newRating)
        updateRating(clampedRating)
    }
}

// MARK: - Haptic
class HapticManager {
    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

