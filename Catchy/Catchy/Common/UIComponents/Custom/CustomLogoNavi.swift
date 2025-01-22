//
//  CustomLogoNavi.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct CustomLogoNavi: View {
    
    @EnvironmentObject var cotainer: DIContainer
    
    let onlyLogo: Bool
    
    init(onlyLogo: Bool) {
        self.onlyLogo = onlyLogo
    }
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Color.white
                .s1w()
            
            logoGroup
                .padding(.leading, 22)
                .padding(.trailing, 29)
        })
        .frame(maxWidth: .infinity, maxHeight: 115)
    }
    
    private var logoGroup: some View {
        HStack(content: {
            Icon.topLogo.image
                .resizable()
                .frame(width: 76, height: 21)
            
            if onlyLogo {
                
                Spacer()
                
            } else {
                
                Spacer()
                
                CustomTextField(text: .constant(""), searchTextField: .homeView)
            }
        })
        .frame(height: 32)
        .padding(.bottom, 14)
    }
}

struct CustomLogoNavi_Preview: PreviewProvider {
    static var previews: some View {
        CustomLogoNavi(onlyLogo: false)
            .previewLayout(.sizeThatFits)
    }
}
