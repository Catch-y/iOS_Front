//
//  DateSelectButton.swift
//  Catchy
//
//  Created by 정의찬 on 1/26/25.
//

import SwiftUI

struct DateSelectButton: View {
    
    let activeDate: ActiveDate
    let onSelctDate: (ActiveDate) -> Void
    
    var body: some View {
        Text(activeDate.toKorean())
            .font(.dateBtnText)
            .foregroundStyle(Color.g6)
            .frame(width: 14, height: 19)
            .padding(.vertical, 17)
            .padding(.horizontal, 14)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.g1)
            }
    }
}

#Preview {
    DateSelectButton(activeDate: .saturDay, onSelctDate: { date in
        print(date)
    })
}
