//
//  GroupLogoNavigation.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

struct GroupLogoNavigation: View {
    let onHomeButtonTap: () -> Void
    let onPlusButtonTap: () -> Void

    var body: some View {
        HStack {
            Button(action: onHomeButtonTap) {
                Icon.topLogo.image
                    .resizable()
                    .frame(width: 76, height: 21)
            }
            
            Spacer()
            
            Button(action: onPlusButtonTap) {
                Icon.plusGroup.image
                    .resizable()
                    .frame(width: 16, height: 17)
            }
        }
        .padding()
        .background(Color.white)
        .s1w()
    }
}

// MARK: - Preview
struct GroupLogoNavigation_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            GroupLogoNavigation(
                onHomeButtonTap: {
                    print("뒤로가기 버튼 클릭")
                },
                onPlusButtonTap: {
                    print("플러스 버튼 클릭")
                }
            )
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
