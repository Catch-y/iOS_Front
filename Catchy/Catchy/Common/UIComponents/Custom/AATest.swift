//
//  Test.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct AATest: View {
    var body: some View {
        VStack {
            CustomLogoNavi(onlyLogo: false)
            
            Spacer()
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    AATest()
}
