//
//  CategoryCard.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import SwiftUI

struct CategoryCard: View {
    
    var categoryType: CategoryType
    var color : Color = Color.clear 
    
    
    init(categoryType: CategoryType) {
        self.categoryType = categoryType
        self.setColor()
    }
    
    var body: some View {
        Text(categoryType.rawValue)
    }
    
    private mutating func setColor(){
        switch categoryType {
        case .BAR:
            color = Color.bar
        case .CAFE :
            color = Color.cafe
        case .CULTURELIFE:
            color = Color.culturaLife
        case .EXPRERIENCE :
            color = Color.experience
        case .REST :
            color = Color.rest
        case .RESTAURANT :
            color = Color.restaurant
        case .SPORT :
            color = Color.sport
        }
    }
}

#Preview {
    CategoryCard(categoryType: .BAR)
}
