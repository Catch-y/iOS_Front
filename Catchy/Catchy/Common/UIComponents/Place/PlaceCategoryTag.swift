//
//  PlaceCategoryTag.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/26/25.
//

import SwiftUI

struct PlaceCategoryTag: View {
    
    let category: String
    let fontColor: Color
    let color: Color
    
    init(category: String, fontColor: Color = .g6 ,color: Color = .g2) {
        self.category = category
        self.fontColor = fontColor
        self.color = color
    }
    
    fileprivate enum PlaceCategoryTagContsants {
        static let categoryTagPadding: EdgeInsets = .init(top: 4, leading: 13, bottom: 4, trailing: 13)
    }
    
    var body: some View {
        Text(category)
            .font(.courseTag)
            .foregroundStyle(fontColor)
            .padding(PlaceCategoryTagContsants.categoryTagPadding)
            .background {
                RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius)
                    .fill(color)
            }
    }
}
