//
//  FullScreenMap.swift
//  Catchy
//
//  Created by 정의찬 on 2/19/25.
//

import SwiftUI

struct FullScreenMap: View {
    
    @EnvironmentObject var container: DIContainer
    @ObservedObject var viewModel: AppleMapViewModel
    
    var body: some View {
        VStack(alignment: .center, content: {
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: "코스 경로", rightNaviIcon: nil)
            .padding(.horizontal, 16)
            
            AppleMap(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 13)
    }
}

struct FullScreenMap_Preview: PreviewProvider {
    static var previews: some View {
        FullScreenMap(viewModel: AppleMapViewModel(placeInfoData: [], container: DIContainer()))
            .environmentObject(DIContainer())
    }
}
