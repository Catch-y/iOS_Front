//
//  ProfileImageView.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI
import Kingfisher

struct ProfileImage: View {
    
    /// 이미지, 크기, 눌렀을 시 동작
    let imageURL: String
    let size: Double
    let onEdit: () -> Void
    
    init(imageURL: String, size: Double, onEdit: @escaping () -> Void) {
        self.imageURL = imageURL
        self.size = size
        self.onEdit = onEdit
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing, content: {
            
            KFImage(URL(string: imageURL))
                .placeholder {
                    ProgressView()
                        .controlSize(.large)
                }
                .retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
            
            // 수정 버튼
            Button(action: onEdit) {
                Icon.pencil.image
                    .resizable()
                    .frame(width: size * 0.3, height: size * 0.3)
                
            }
        })
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(
            imageURL: "https://static.wanted.co.kr/images/company/21181/dazl35csneuul4f9__1080_790.jpg",
            size: 104,
            onEdit: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
