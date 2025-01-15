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
            toggleLike()
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
    }
    
    func heartIcon() -> Image {
        if data.isLike {
            return Icon.heart.image
        } else {
            return Icon.empyHeart.image
        }
    }
}

struct LikeButton_Preview: PreviewProvider {
    static var previews: some View {
        LikeButton(data: .constant(RecommendPlaceResponse(placeId: 1, placeImage: "s", placeName: "s", subCategory: "s", isLike: true, starPoint: 2.1, placeLocation: "s", placeOperTime: "s")), action: {print("hello")})
    }
}
