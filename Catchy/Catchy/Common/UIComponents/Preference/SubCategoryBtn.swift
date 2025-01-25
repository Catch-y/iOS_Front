//
//  SubCategoryBtn.swift
//  Catchy
//
//  Created by 정의찬 on 1/25/25.
//

import SwiftUI

struct SubCategoryBtn: View {
    
    let subCategoryName: String
    let onSubCategorySelected: (String) -> Void
    
    @State var isSelected: Bool = false
    
    init(subCategoryName: String, onSubCategorySelected: @escaping (String) -> Void) {
        self.subCategoryName = subCategoryName
        self.onSubCategorySelected = onSubCategorySelected
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.4)) {
                isSelected.toggle()
                
                onSubCategorySelected(subCategoryName)
            }
        }, label: {
            
            ZStack(content: {
                RoundedRectangle(cornerRadius: 30)
                    .fill(isSelected ? Color.m2 : Color.white)
                    .stroke(isSelected ? Color.m6 : Color.clear, lineWidth: 1)
                    .frame(maxWidth: 153, minHeight: 48)

                Text(subCategoryName)
                    .font(.Subtitle3)
                    .foregroundStyle(isSelected ? Color.m6 : Color.g6)
            })  
        })
    }
}

struct SubCategoryBtn_Preview: PreviewProvider {
    static var previews: some View {
        SubCategoryBtn(subCategoryName: "요리주점") { name in
            print(name)
        }
    }
}
