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
            .font(.pretend(type: .extraBold, size: 9)) /* 1번째 수정 -> 폰트 스타일 정의해라 */
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, minHeight: 14) /* 2번째 수정 -> 프레임 동적으로 */
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(categoryType.setColor())
            }
    }
}
