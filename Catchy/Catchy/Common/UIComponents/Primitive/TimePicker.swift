//
//  TimePicker.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/24/25.
//

import SwiftUI

/// 시간 선택 피커
struct TimePicker: View {
    // MARK: - Property
    @Binding var selectedTime: Date?
    @Binding var isExpand: Bool
    
    // MARK: - Constants
    fileprivate enum TimePickerConstants {
        static let timeText: String = "00:00"
        static let btnPadding: EdgeInsets = .init(top: 17, leading: 29, bottom: 17, trailing: 29)
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 1
    }
    
    // MARK: - Init
    init(selectedTime: Binding<Date?>, isExpand: Binding<Bool>) {
        self._selectedTime = selectedTime
        self._isExpand = isExpand
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                isExpand.toggle()
            }
        }, label: {
            btnText
        })
        .glassEffect(.regular, in: .rect(cornerRadius: TimePickerConstants.cornerRadius))
        
    }
    
    /// 버튼 내부 컨텐츠
    private var btnText: some View {
        HStack(content: {
            Text(selectedTime?.timeString() ?? TimePickerConstants.timeText)
                .font(.body1_2)
                .foregroundStyle(selectedTime == nil ? Color.g3 : Color.g6)
            Spacer()
            Image(.bottomChevron)
        })
        .padding(TimePickerConstants.btnPadding)
        .background {
            RoundedRectangle(cornerRadius: TimePickerConstants.cornerRadius)
                .fill(Color.clear)
                .stroke(Color.g3, style: .init(lineWidth: TimePickerConstants.lineWidth))
        }
    }
}

#Preview {
    @Previewable @State var isExpand: Bool = false
    TimePicker(selectedTime: .constant(nil), isExpand: $isExpand)
}
