//
//  EmptyReviewPhoto.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import SwiftUI

struct EmptyReviewPhoto: View {
    
    @Binding var count: Int
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.g3)
                .stroke(.clear)
            
            VStack(spacing: 12) {
                
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.white)

                
                HStack(spacing: 4) {
                    Text("\(count)")
                        .font(.body3_SM)
                        .foregroundStyle(.g5)
                    
                    Text("/")
                        .font(.body3)
                        .foregroundStyle(.g4)
                    
                    Text("5")
                        .font(.body3)
                        .foregroundStyle(.g4)
                }
                
            }
            .padding(.top, 12)
        }
        .frame(width: 113, height: 113)
    }
}
