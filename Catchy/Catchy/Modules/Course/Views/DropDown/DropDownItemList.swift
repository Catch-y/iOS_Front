//
//  DropDownMenuList.swift
//  Catchy
//
//  Created by LEE on 1/16/25.
//

import SwiftUI

struct DropDownItemList: View {

    // MARK: - Properties
    var items : [String]
    
    let didTapItem: (_ item: String) -> Void
    
    var body: some View {
        // TODO: - 스크롤 안되는 문제있음.
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
        .frame(width: 180, height: 100)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.g3, lineWidth: 1)
        }
    }
}
 
