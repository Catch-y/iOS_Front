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
    
    /// 왼쪽 및 오른쪽 네비 그룹
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
    
    /// 네비 타이틀 설정
    @ViewBuilder
    private var naviTitle: some View {
        if let title = title {
            Spacer()
            
            Text(title)
                .font(.Subtitle3_SM)
                .foregroundStyle(Color.g7)
                .padding(.leading, leftNaviIcon == nil ? 15 : 0)
 
            Spacer()
        } else {
            Spacer()
        }
    }
    
    /// 네비게이션 내부 버튼 생성
    /// - Parameter image: 버튼에 사용할 이미지
    /// - Returns: 버튼 반환
    private func makeNaviButton(image: Image) -> some View {
        return Button(action: {
                action()
        }, label: {
            image
            .fixedSize()
        })
    }
    
    /// 네비게이션 내부 타이틀
    /// - Parameter title: 네비게이션 사용 타이틀
    /// - Returns: 네비게이션 타이틀 반환
    private func makeTitle(_ title: String) -> some View {
        Text(title)
            .font(.naviFont)
            .foregroundStyle(Color.g7)
    }
}

struct CustomNavigation_Prevview: PreviewProvider {
    static var previews: some View {
        CustomNavigation(action: {print("평점, 리뷰 보기")}, title: "평점, 리뷰 보기", rightNaviIcon: nil, isShadow: true)
    }
}
