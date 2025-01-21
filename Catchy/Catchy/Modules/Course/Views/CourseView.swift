//
//  CourseView.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI
import FloatingButton

struct CourseView: View {
    
    @ObservedObject var viewModel: CourseViewModel = dummnyCourseViewModel.dummy()
    
    @State private var isDropdownOpen = false
    @State var segment: CourseSegment = .diy
    
    var body: some View {
        
        VStack(alignment: .center){
            CustomLogoNavi(onlyLogo: true)
            CustomSegment<CourseSegment>(selectedSegment: $segment)
                .frame(height: 66)
            // TODO: - 드랍 다운 메뉴
        }
        .ignoresSafeArea(.all)
        
        
        
        ScrollView{
            VStack(alignment: .center, spacing: 18){
                ForEach(viewModel.courseList, id: \.id){ course in
                    CourseListCard(course: course)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 80)
        .refreshable{
            
        }
        
    }
    
}

#Preview {
    CourseView()
}
