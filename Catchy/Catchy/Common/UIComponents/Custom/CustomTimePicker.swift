//
//  CustomTimPicker.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

struct CustomTimePicker: View {
    
    @State var selectedTime = Date()
    @Binding var isExpand: Bool
    
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpand.toggle()
                }
            }, label: {
                ZStack(alignment: .center, content: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                        .stroke(Color.g2, style: .init(lineWidth: 1))
                        .frame(width: 177, height: 54)
                    
                    HStack(spacing: 75, content: {
                        Text(DataFormatter.shared.timeString(from: selectedTime))
                            .font(.Body1_2)
                            .foregroundStyle(Color.g3)
                        
                        Icon.bottomChevron.image
                            .fixedSize()
                    })
                })
            })
        }
    }
}

struct CustomTimePicker_Preview: PreviewProvider {
    static var previews: some View {
        CustomTimePicker(isExpand: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
