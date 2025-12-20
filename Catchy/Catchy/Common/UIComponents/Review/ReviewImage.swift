//
//  ReviewImage.swift
//  Catchy
//
//  Created by euijjang97 on 12/20/25.
//

import SwiftUI

struct ReviewImageView: View {
    let image: UIImage
    let action: () -> Void
    
    let imageSize: CGFloat = 110
    let xSize: CGFloat = 14
    
    init(image: UIImage, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing, content: {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius))
            
            Image(systemName: "xmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: xSize, height: xSize)
                .padding(6)
                .glassEffect(.regular.interactive(), in: .circle)
                .onTapGesture {
                    withAnimation {
                        action()
                    }
                }
                .offset(x: -7, y: 6)
        })
    }
}
