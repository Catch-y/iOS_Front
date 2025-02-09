//
//  GroupNavigation.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI

struct GroupNavigation: View {
    let title: String
    let onBackButtonTap: () -> Void

    var body: some View {
        ZStack {
            // 가운데 정렬된 제목
            Text(title)
                .font(.Subtitle3)
                .foregroundStyle(.g7)

            // 왼쪽 뒤로가기 버튼
            HStack {
                Button(action: onBackButtonTap) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.g4)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

    }
}

struct GroupNavigation_Preview : PreviewProvider {
    static var previews: some View {
        GroupNavigation(title: "투표하기") {
            print("뒤로가기 버튼 클릭")
        }
    }
}

