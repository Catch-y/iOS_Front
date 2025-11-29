//
//  LikeButton.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/26/25.
//

import SwiftUI

struct LikeButton<T: Likeable>: View {
    
    // MARK: - Property
    @Binding var data: T
    let action: () -> Void
    let style: LikeButtonStyle
    @Namespace var namespace
    
    enum LikeButtonStyle {
        case withCircle(size: CGFloat = 20)
        case plain(size: CGFloat = 17)
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                toggleLike()
            }
        }, label: {
            styledHeartIcon
        })
        .glassEffect(.regular.interactive(), in: .circle)
        .glassEffectID("like", in: namespace)
    }
    
    @ViewBuilder
    private var styledHeartIcon: some View {
        switch style {
        case .withCircle(let size):
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: size, height: size)
                heartIcon
            }
        case .plain(let size):
            heartIcon
                .resizable()
                .frame(width: size, height: size)
        }
    }
    
    func toggleLike() {
        data.liked.toggle()
        action()
    }
    
    private var heartIcon: Image {
        data.liked ? Image(.heart) : Image(.emptyHeart)
    }
}
