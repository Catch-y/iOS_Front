//
//  DIYBucketButton.swift
//  Catchy
//
//  Created by LEE on 2/20/25.
//

import SwiftUI

/// 장소 상세 화면의 담은 장소 화면 버튼
struct DIYBucketButton: View {
    
    @ObservedObject var viewModel: DIYCourseViewModel
        
    init(viewModel: DIYCourseViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: {
            viewModel.container.navigationRouter.push(to: .placeBucketView(viewModel: viewModel))
        }, label: {
            ZStack {
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                
                Text("\($viewModel.selectedPlaceList.count)")
                    .font(.Body1_2)
                    .foregroundStyle(.main)
                    .padding(.bottom, 24)
                    .padding(.leading, 24)
                
                
                Icon.bucket.image
            }
        })
    }
}
