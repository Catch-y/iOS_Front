//
//  CustomTimPicker.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

struct CustomTimePicker: View {
    
    @Binding var selectedTime: Date?
    @Binding var isExpand: Bool
    
    
    var body: some View {
            Button(action: {
                withAnimation {
                    isExpand.toggle()
                }
            }, label: {
                    HStack(content: {
                        Text(selectedTime == nil ? "00:00" : DataFormatter.shared.timeString(from: selectedTime!))
                            .frame(minWidth: 36, minHeight: 20)
                            .font(.Body1_2)
                            .foregroundStyle(selectedTime == nil ? Color.g3 : Color.g6)
                        
                        Spacer()
                        
                        Icon.bottomChevron.image
                            .fixedSize()
                    })
                    .padding(.vertical, 17)
                    .padding(.horizontal, 29)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.clear)
                            .stroke(Color.g3, style: .init(lineWidth: 1))
                    }
            })
    }
}
