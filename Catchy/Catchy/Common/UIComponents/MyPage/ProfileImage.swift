//
//  ProfileImageView.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI

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
            // 프로필 이미지
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            
            // 수정 버튼
            Button(action: onEdit) {
                Icon.pencil.image
                    .resizable()
                    .renderingMode(.template) // ✅ 아이콘 색상 적용 가능하게 변경
                    .foregroundColor(.black) // ✅ 색상을 검정으로 설정
                    .frame(width: size * 0.3, height: size * 0.3)
                    .scaledToFit() // ✅ 아이콘이 작을 경우 크기 조절
            }
        })
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(
            imageURL: "https://your-image-url.com/profile.jpg",
            size: 80,
            onEdit: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
