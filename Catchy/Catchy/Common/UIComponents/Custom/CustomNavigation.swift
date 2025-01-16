//
//  CustomNavigation.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

enum CustomNavigationType {
    case base
    case shadow
}

struct CustomNavigation: View {
    
    let action: () -> Void
    let title: String?
    var leftNaviIcon: Image? = Icon.leftChevron.image
    var rightNaviIcon: Image? = Icon.close.image
    let customNavigationType: CustomNavigationType
    
    init(
        action: @escaping () -> Void,
        title: String?,
        rightNaviIcon: Image?,
        customNavigationType: CustomNavigationType = .base
    ) {
        self.action = action
        self.title = title
        self.rightNaviIcon = rightNaviIcon
        self.customNavigationType = customNavigationType
    }
    
    init(
        action: @escaping () -> Void,
        title: String?,
        leftNaviIcon: Image?,
        customNavigationType: CustomNavigationType = .base
    ) {
        self.action = action
        self.title = title
        self.leftNaviIcon = leftNaviIcon
        self.customNavigationType = customNavigationType
    }
    
    
    var body: some View {
        switch customNavigationType {
        case .base:
            baseNavi
        case .shadow:
            shadowNavi
        }
    }
    
    private var shadowNavi: some View {
        ZStack(alignment: .bottom, content: {
            Color.white
                .s1w()
            
            baseNavi
                .padding(.bottom, 14)
        })
        .frame(maxWidth: .infinity, maxHeight: 115)
    }
    
    private var baseNavi: some View {
        HStack(alignment: .center, content: {
            if let leftNaviIcon = leftNaviIcon {
                makeNaviButton(image: leftNaviIcon)
                
                naviTitle
            } else if let rightNaviIcon = rightNaviIcon {
                naviTitle
                
                makeNaviButton(image: rightNaviIcon)
            }
        })
        .frame(width: 370)
    }
    
    @ViewBuilder
    private var naviTitle: some View {
        if let title = title {
            Spacer()
            
            Text(title)
                .font(.naviFont)
                .foregroundStyle(Color.g7)
            
            Spacer()
        } else {
            Spacer()
        }
    }
    
    private func makeNaviButton(image: Image) -> some View {
        return Button(action: {
            action()
        }, label: {
            image
            .fixedSize()
        })
    }
}

struct CustomNavigation_Prevview: PreviewProvider {
    static var previews: some View {
        CustomNavigation(action: {print("hello")}, title: nil, rightNaviIcon: nil)
    }
}
