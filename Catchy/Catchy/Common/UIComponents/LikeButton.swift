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
    
    /// 장소 상세 화면인 경우
    /// Circle 필요 없음
    let forPlace: Bool
    
    init(data: Binding<T>,
         action: @escaping () -> Void,
         forPlace: Bool = false
    ) {
        self._data = data
        self.action = action
        self.forPlace = forPlace
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                toggleLike()
            }
        }, label: {
            ZStack(alignment: .center, content: {
                if !forPlace {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                    heartIcon()
                    
                } else {
                    heartIcon()
                        .resizable()
                        .frame(width: 17, height: 17)
                }
                
               
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
