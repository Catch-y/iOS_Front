//
//  LoadingView.swift
//  Catchy
//
//  Created by 권용빈 on 2/10/25.
//

import SwiftUI

/// 로딩 상태를 표시하는 View
/// - 중앙 정렬된 Progress Indicator 표시
struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            
            ProgressView()
                .controlSize(.regular)
            
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
