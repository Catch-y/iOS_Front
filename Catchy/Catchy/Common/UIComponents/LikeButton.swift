//
//  LikeButton.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI

struct LikeButton: View {
    
    @Binding var data: RecommendPlaceResponse
    let action: () -> Void
    
    init(data: Binding<RecommendPlaceResponse>,
         action: @escaping () -> Void) {
        self._data = data
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                toggleLike()
            }
        }, label: {
            ZStack(alignment: .center, content: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                heartIcon()
            })
            .s1w()
        })
    }
    
    func toggleLike() {
        data.isLike.toggle()
        action()
        print(data.isLike)
    }
    
    func heartIcon() -> Image {
        if data.isLike {
            return Icon.heart.image
        } else {
            return Icon.empyHeart.image
        }
    }
}
