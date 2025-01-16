//
//  CourseTimePerson.swift
//  Catchy
//
//  Created by 정의찬 on 1/16/25.
//

import SwiftUI

struct CourseTimePerson: View {
    
    let name: String
    let num: String
    
    var body: some View {
        HStack(spacing: 9, content: {
            Text(name)
                .font(.caption1)
                .foregroundStyle(Color.m5)
            
            Text(num)
                .font(.caption1_SM)
                .foregroundStyle(Color.g5)
        })
        .padding(.vertical, 8)
        .padding(.horizontal, 17)
        .background {
            RoundedRectangle(cornerRadius: 39)
                .fill(Color.clear)
                .stroke(Color.m5, lineWidth: 1)
        }
    }
}
