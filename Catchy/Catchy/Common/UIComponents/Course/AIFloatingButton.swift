//
//  AIFloatingButton.swift
//  Catchy
//
//  Created by LEE on 1/21/25.
//

import SwiftUI

struct AIFloatingButton: View {
    
    @Binding var isOpen : Bool

    
//    var body: some View {
//        HStack(spacing: 19) {
//            Text("AI 추천 코스")
//                .font(.body2)
//                .foregroundColor(.white)
//                .opacity(1)
//            
//            ZStack{
//                Color.white
//                    .frame(width: 70, height: 70)
//                    .clipShape(Circle())
//                Icon.courseAI.image
//                    .resizable()
//                    .frame(width: 32, height: 32)
//            }
//        }
//        .frame(width: 70)
//    }
    var body: some View {

            Text("AI 추천 코스")
                .font(.body2)
                .foregroundColor(.white)
                .opacity(isOpen ? 1 : 0)
                .padding(.trailing, 17)
            ZStack{
                Color.white
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                Icon.courseAI.image
                    .resizable()
                    .frame(width: 32, height: 32)
            }

    }
}


