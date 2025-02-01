//
//  MypageItem.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import SwiftUI

struct MyPageItem: View {
    let icon: Image
    let title: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5, content: {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)

                Text(title)
                    .font(.body2)
                    .foregroundColor(.g6)
            })
            .frame(width: 112, height: 98)
            .background(.bg1)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}


struct MyPageItem_Previews: PreviewProvider {
    static var previews: some View {
        MyPageItem(icon: Icon.document.image, title: "취향 설문") {
            print("버튼 클릭됨")
        }
        .previewLayout(.sizeThatFits)
    }
}
