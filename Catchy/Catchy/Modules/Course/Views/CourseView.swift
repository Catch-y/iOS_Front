//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI

struct CourseView: View {
    
    @ObservedObject var viewModel: CourseViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading, content: {
            CustomLogoNavi(onlyLogo: true)
            Spacer()
            // TODO: - 세그먼트 컨트롤
            // TODO: - 드랍 다운 메뉴
        })
        .ignoresSafeArea(.all)
        VStack(alignment: .center, content: {
            CourseListCard(course: <#T##CourseListResponse#>)
        })
    }
    
}

#Preview {
    CourseView()
}
