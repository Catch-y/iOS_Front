//
//  GroupNavigation.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI

struct GroupNavigation: View {
    
    @EnvironmentObject var container: DIContainer
    
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
                Button(action: {
                    container.navigationRouter.pop()
                })
                {
                    Icon.leftChevron.image
                        .foregroundStyle(.g4)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .s1w()

    }
}

struct GroupNavigation_Preview : PreviewProvider {
    static var previews: some View {
        GroupNavigation(title: "투표하기") {
            print("뒤로가기 버튼 클릭")
        }
    }
}

