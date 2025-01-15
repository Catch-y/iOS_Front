//
//  DropDownView.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import SwiftUI

struct DropDownView: View {
    
    @State private var isPresented: Bool = false
    @State private var selectedItem: String? = nil
    
    var placeholder: String
    
    @Binding var items: [String]
    
    var onItemSelected: ((String) -> Void)?
    
    init(placeholder: String, items: Binding<[String]>){
        self.placeholder = placeholder
        self._items = items
    }
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text(self.selectedItem ?? self.placeholder)
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
                    Spacer(minLength: 60)
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

