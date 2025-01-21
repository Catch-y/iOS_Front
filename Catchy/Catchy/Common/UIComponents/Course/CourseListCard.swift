//
//  CourseListCard.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI

struct CourseListCard: View {
    
    var course : CourseListResponse
    
    init(course: CourseListResponse) {
        self.course = course
    }
    
    var body: some View {
        HStack(content: {
            Image("ㅇ")
            VStack(content: {
                Text("코스 이름")
                  
            })
        })
    }
}

