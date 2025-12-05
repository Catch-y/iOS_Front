//
//  SearchChip.swift
//  Catchy
//
//  Created by euijjang97 on 12/5/25.
//

import SwiftUI

struct SearchChip: View {
    
    let text: String
    let action: () -> Void
    let delete: () -> Void
    @Namespace var namespace
    
    fileprivate enum SearchChipConstants {
        static let searchSpacing: CGFloat = 0
        static let imagePadding: CGFloat = 4
        static let buttonPadding: EdgeInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 6)
        static let xmark: String = "xmark"
    }
    
    var body: some View {
        HStack(spacing: SearchChipConstants.searchSpacing, content: {
            Button(action: {
                withAnimation {
                    action()
                }
            }, label: {
                Text(text)
                    .font(.body1_2)
                    .foregroundStyle(.black)
                    .lineLimit(1)
            })
            
            Button(action: {
                withAnimation {
                    delete()
                }
            }, label: {
                Image(systemName: SearchChipConstants.xmark)
                    .font(.caption1)
                    .foregroundStyle(.g5)
                    .padding(SearchChipConstants.imagePadding)
            })

        })
        .padding(SearchChipConstants.buttonPadding)
        .glassEffect(.regular.interactive(), in: .capsule)
    }
}
