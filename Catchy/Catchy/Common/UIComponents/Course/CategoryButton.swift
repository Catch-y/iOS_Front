//
//  CategoryButton.swift
//  Catchy
//
//  Created by LEE on 2/4/25.
//

import SwiftUI

struct CategoryButton: View {
    
    @Binding var isSelected: Bool
    
    /// 서브 카테고리 타입 문자열
    /// ex) 커피전문점, 애견카페
    let text: String
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }, label: {
            Text(text)
                .padding(.horizontal, 19)
                .padding(.vertical, 9)
                .font(.body3_SM)
                .foregroundStyle(isSelected ? .m6 : .g4)
                .background {
                    RoundedRectangle(cornerRadius: 16.5)
                        .fill(isSelected ? .m1 : .white)
                        .stroke(isSelected ? .m6 : .g3, lineWidth: 1)
                }
                
        })
    }
}



struct CategoryButton_Preview: PreviewProvider {
    

    static var previews: some View {
        
        
        CategoryButton(isSelected: .constant(false), text: "애견카페")            .previewLayout(.sizeThatFits)

    }
}

