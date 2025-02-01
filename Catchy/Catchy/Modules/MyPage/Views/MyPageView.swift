//
//  MyPageView.swift
//  Catchy
//
//  Created by 권용빈 on 2/1/25.
//

import SwiftUI

struct MyPageView: View {
    
    @StateObject var viewModel: MyPageViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    private var ProfileSectionView : some View {
        return VStack(spacing: 9){
            
    }
}
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            MyPageView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
