//
//  DIYBackButton.swift
//  Catchy
//
//  Created by LEE on 2/20/25.
//

import SwiftUI

/// 장소 상세 화면의 네비게이션 POP 버튼
struct DIYBackButton: View {
    
    @ObservedObject var viewModel: DIYCourseViewModel
        
    init(viewModel: DIYCourseViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: {
            viewModel.onAppearByPop = true
            viewModel.placeDetailResponse = nil
            viewModel.container.navigationRouter.pop()
        }, label: {
            ZStack {
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                
                Icon.leftChevron.image
            }
        })
    }
}
