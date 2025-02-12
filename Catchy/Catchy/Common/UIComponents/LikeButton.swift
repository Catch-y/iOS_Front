//
//  LikeButton.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI

struct LikeButton<T: Likeable>: View {
    
    @Binding var data: T
    let action: () -> Void
    
    init(data: Binding<T>,
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
        data.liked.toggle()
        action()
        print(data.liked)
    }
    
    func heartIcon() -> Image {
        if data.liked {
            return Icon.heart.image
        } else {
            return Icon.empyHeart.image
        }
    }
}
