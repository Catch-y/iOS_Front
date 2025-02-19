//
//  DIYCloseButton.swift
//  Catchy
//
//  Created by LEE on 2/20/25.
//

import SwiftUI

/// 장소 상세 화면의 닫기 버튼
struct DIYCloseButton: View {
    
    @ObservedObject var viewModel: DIYCourseViewModel
        
    init(viewModel: DIYCourseViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: {
            viewModel.container.navigationRouter.popToRootView()
            
        }, label: {
            ZStack {
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                
                Icon.close.image
            }
            
        })
    }
}
