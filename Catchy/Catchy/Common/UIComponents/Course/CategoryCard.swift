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
            .font(.pretend(type: .extraBold, size: 9))
            .foregroundStyle(.white)
            .padding(.vertical, 3)
            .frame(width: 50, height: 14)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 4))

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
