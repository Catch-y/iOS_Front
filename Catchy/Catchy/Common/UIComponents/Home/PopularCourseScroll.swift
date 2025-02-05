//
//  PopularCourseScroll.swift
//  Catchy
//
//  Created by 정의찬 on 2/5/25.
//

import SwiftUI

struct PopularCourseScroll: View {
    
    @Binding var index: Int
    let totalPages: Int
    
    var body: some View {
        HStack(spacing: 5, content: {
            Group {
                Text("\(index)")
                
                Text("|")
                
                Text("\(totalPages)")
            }
            .font(.caption3)
            .foregroundStyle(Color.white)
        })
        .padding(.vertical, 5)
        .padding(.horizontal, 7)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 0)
        }
    }
}

struct PopularCourseScroll_Preview: PreviewProvider {
    static var previews: some View {
        PopularCourseScroll(index: .constant(1), totalPages: 10)
    }
}
