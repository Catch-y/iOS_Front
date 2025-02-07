//
//  CourseDetailView.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import SwiftUI
import Kingfisher

struct CourseDetailView: View {
    
    @StateObject var viewModel: CourseDetailViewModel
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack(content: {
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: "코스 정보", rightNaviIcon: nil, isShadow: true)
            
            
        })
    }
}
