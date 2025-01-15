//
//  DropDownView.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import SwiftUI

struct DropDownView: View {
    
    // MARK: - Properties
    @Binding var selectedItem: String
    @State private var isPresented: Bool = false
    
    var placeholder: String
    var items: [String]
    var onItemSelected: ((String) -> Void)?
    
    // MARK: - UI Components
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text(self.selectedItem.isEmpty ? self.placeholder : self.selectedItem)
                    .foregroundColor(.g5)
                Spacer()
                // TODO: - 이미지 카탈로그 필요함.
                //Image(systemName: "chevron.down")
            }
            .font(.body2)
            .padding(.horizontal, 25)
        }
        .frame(width: 180, height: 45)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.g3, lineWidth: 1)
        }
        .overlay(alignment: .top) {
            VStack{
                if isPresented {
                    Spacer(minLength: 45)
                    DropDownItemList(items: items){ item in
                        isPresented = false
                        selectedItem = item
                        onItemSelected?(item)
                    }
                }
            }
        }
    }
}

