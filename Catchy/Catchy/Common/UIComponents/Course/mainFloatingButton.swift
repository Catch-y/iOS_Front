//
//  mainFloattingButton.swift
//  Catchy
//
//  Created by LEE on 1/21/25.
//

import SwiftUI

struct MainFloatingButton: View {
    
    @Binding var isOpen : Bool
    
    var body: some View {
        ZStack{
            (isOpen ? Color.main : Color.white)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .s1w()
            Image(systemName: "plus")
                .frame(width: 17, height: 17)
                .foregroundStyle(isOpen ? .white : .g4)
                .rotationEffect(.degrees(isOpen ? 45 : 0))
                .animation(.spring(), value: isOpen)
        }
    }
}
