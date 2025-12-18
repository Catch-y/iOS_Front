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
    }
    
    @ViewBuilder
    private var styledHeartIcon: some View {
        switch style {
        case .withCircle(let size):
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: size, height: size)
               heart(size: 12)
            }
            .glassEffect(.regular.interactive(), in: .circle)
            .glassEffectID("like", in: namespace)
        case .plain(let size):
            heart(size: size)
        }
    }
    
    func toggleLike() {
        data.liked.toggle()
        action()
    }
    
    private func heart(size: CGFloat) -> some View {
        heartIcon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .tint(data.liked ? .main : .g4)
    }
    
    private var heartIcon: Image {
        data.liked ? Image(systemName: "heart.fill") : Image(systemName: "heart")
    }
}
