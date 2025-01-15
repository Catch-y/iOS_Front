//
//  DropDownMenuList.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import SwiftUI

struct DropDownItemList: View {

    var items : [String]
    
    let didTapItem: (_ item: String) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    Button {
                        didTapItem(item)
                    } label: {
                        Text(item)
                            .font(.body2)
                            .foregroundColor(.g5)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical)
        }
        .frame(width: 180, height: 150)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.g3, lineWidth: 1)
        }
    }
}
 
struct DropDownItem_Previews: PreviewProvider {
    static var previews: some View {
        DropDownItemList(items: ["1","2","3","4"], didTapItem: { _ in })
    }
}
