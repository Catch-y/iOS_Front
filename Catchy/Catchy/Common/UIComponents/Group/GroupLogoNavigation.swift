//
//  GroupLogoNavigation.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

struct GroupLogoNavigation: View {

    let onPlusButtonTap: () -> Void

    var body: some View {
        
        ZStack(alignment: .bottom, content: {
            Color.white
                .s1w()
            
            topLogoView
                .padding(.leading, 22)
                .padding(.trailing, 29)
                .padding(.bottom, 14)
        })
        .frame(maxWidth: .infinity, maxHeight: 115)
    }
    
    private var topLogoView: some View {
        HStack {
                Icon.topLogo.image
                    .resizable()
                    .frame(width: 76, height: 21)
            
            Spacer()
            
            Button(action: onPlusButtonTap) {
                Icon.plusGroup.image
                    .resizable()
                    .frame(width: 16, height: 17)
            }
        }
    }
}

// MARK: - Preview
struct GroupLogoNavigation_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            GroupLogoNavigation(
                onPlusButtonTap: {
                    print("플러스 버튼 클릭")
                }
            )
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
