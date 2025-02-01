//
//  CategoryCard.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI

struct CategoryCard: View {
    
    var categoryType: CategoryType
    
    init(categoryType: CategoryType) {
        self.categoryType = categoryType
    }
    
    var body: some View {
        Text(categoryType.rawValue)
            .font(.categoryTag)
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, minHeight: 14)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(categoryType.setColor())
            }
    }
}
