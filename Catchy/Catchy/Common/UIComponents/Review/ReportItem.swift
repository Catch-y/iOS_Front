//
//  ReportItem.swift
//  Catchy
//
//  Created by 권용빈 on 1/28/25.
//

import SwiftUI

struct ReportItem: View {
    
    let reason: ReviewReportReason
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 14, content: {
                Image(isSelected ? "checkBtnSelected" : "checkBtnUnselected")
                
                Text(reason.rawValue)
                    .font(.Body1_2)
                    .foregroundColor(.g6)
            })
        }
    }
}

struct ReportItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // 1. 선택되지 않은 상태
            ReportItem(
                reason: .notRelatedToPlace,
                isSelected: false,
                onSelect: {
                    print("선택되지 않은 항목 클릭됨")
                }
            )
            
            // 2. 선택된 상태
            ReportItem(
                reason: .obsceneLanguage,
                isSelected: true,
                onSelect: {
                    print("선택된 항목 클릭됨")
                }
            )
        }
        .previewLayout(.sizeThatFits)
    }
}

