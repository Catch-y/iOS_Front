//
//  DIYFloatingButton.swift
//  Catchy
//
//  Created by LEE on 1/21/25.
//

import SwiftUI

struct DIYFloatingButton: View {
    
    @Binding var isOpen : Bool
    
//    var body: some View {
//        HStack(spacing: 19) {
//            Text("코스 DIY")
//                .font(.body2)
//                .foregroundColor(.white)
//                .opacity(isOpen ? 1 : 0)
//            ZStack {
//                Color.white
//                    .frame(width: 70, height: 70)
//                    .clipShape(Circle())
//                Icon.courseDIY.image
//                    .resizable()
//                    .frame(width: 32, height: 32)
//            }
//        }.frame(width: 71)
//    }
    
    var body: some View {
        Text("코스 DIY")
            .font(.body2)
            .foregroundColor(.white)
            .opacity(isOpen ? 1 : 0)
            .padding(.trailing, 17)
        ZStack {
            Color.white
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            Icon.courseDIY.image
                .resizable()
                .frame(width: 32, height: 32)
        }
    }
}

