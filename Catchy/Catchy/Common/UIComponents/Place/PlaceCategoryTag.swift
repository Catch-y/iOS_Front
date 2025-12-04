//
//  PlaceCategoryTag.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/26/25.
//

import SwiftUI

struct PlaceCategoryTag: View {
    
    let category: String
    
    fileprivate enum PlaceCategoryTagContsants {
        static let categoryTagPadding: EdgeInsets = .init(top: 4, leading: 13, bottom: 4, trailing: 13)
    }
    
    var body: some View {
        Text(category)
            .font(.courseTag)
            .foregroundStyle(.g6)
            .padding(PlaceCategoryTagContsants.categoryTagPadding)
            .background {
                RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius)
                    .fill(.g2)
            }
    }
}
