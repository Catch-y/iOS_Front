//
//  CustomNavigation.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct CustomNavigation: View {
    
    let action: () -> Void
    let title: String?
    var leftNaviIcon: Image? = Icon.leftChevron.image
    var rightNaviIcon: Image? = Icon.close.image
    let isShadow: Bool
    
    init(
        action: @escaping () -> Void,
        title: String?,
        rightNaviIcon: Image?,
        isShadow: Bool = false
    ) {
        self.action = action
        self.title = title
        self.rightNaviIcon = rightNaviIcon
        self.isShadow = isShadow
    }
    
    init(
        action: @escaping () -> Void,
        title: String?,
        leftNaviIcon: Image?,
        isShadow: Bool = false
    ) {
        self.action = action
        self.title = title
        self.leftNaviIcon = leftNaviIcon
        self.isShadow = isShadow
    }
    
    
    var body: some View {
        if !isShadow {
            naviGroup
                .frame(maxWidth: .infinity)
        } else {
            ZStack(alignment: .bottom, content: {
                Color.white
                    .s1w()
                
                naviGroup
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
            })
            .frame(maxWidth: .infinity, maxHeight: 113)
        }
        
    }
    
    private var naviGroup: some View {
        HStack(alignment: .center, content: {
            if let leftNaviIcon = leftNaviIcon {
                makeNaviButton(image: leftNaviIcon)
                
                naviTitle
            } else if let rightNaviIcon = rightNaviIcon {
                naviTitle
                
                makeNaviButton(image: rightNaviIcon)
            }
        })
    }
    
    @ViewBuilder
    private var naviTitle: some View {
        if let title = title {
            Spacer()
            
            Text(title)
                .font(.naviFont)
                .foregroundStyle(Color.g7)
                .padding(.leading, 15)
            
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
        CustomNavigation(action: {print("평점, 리뷰 보기")}, title: "평점, 리뷰 보기", leftNaviIcon: nil, isShadow: true)
    }
}
