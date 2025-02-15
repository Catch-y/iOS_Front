//
//  CategoryCard.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI

struct CategoryCard: View {
    
    // MARK: - Properties
    /// 카테고리 타입
    var categoryType: CategoryType
    
    // MARK: - Init
    init(categoryType: CategoryType) {
        self.categoryType = categoryType
    }
    
    var body: some View {
        Text(categoryType.rawValue)
            .font(.caption3)
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, minHeight: 14)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(categoryType.setColor())
            }
    }
}
