//
//  VoteBarChartView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI

struct VoteBarChartView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: VoteBarChartViewModel
    
    // MARK: - Initializer
    init(groupId: Int, voteId: Int) {
        _viewModel = StateObject(wrappedValue: VoteBarChartViewModel(groupId: groupId, voteId: voteId))
    }

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() // 상단 여백
                
                HStack(alignment: .bottom, spacing: 16) { // 막대그래프 간 간격 16
                    Spacer(minLength: 0) // ✅ 막대그래프 중앙 정렬
                    ForEach(viewModel.options) { option in
                        VStack(spacing: 10) {
                            // 막대 그래프
                            RoundedRectangle(cornerRadius: 10)
                                .fill(option.color)
                                .frame(
                                    width: 40,
                                    height: max(CGFloat(option.count) * 15, 8) // ✅ 최소 높이 8
                                )
                            
                            // 카테고리 텍스트 (값이 없어도 항상 표시)
                            Text(option.name)
                                .lineLimit(1)
                                .font(.body3)
                                .multilineTextAlignment(.center)
                                .frame(width: 40)
                                .foregroundStyle(.g5)
                        }
                    }
                    Spacer(minLength: 0) // ✅ 막대그래프 중앙 정렬
                }
                .padding(.bottom, 36)
                .padding(.top, 33)
            }
            .frame(height: 333) // ✅ 흰색 프레임 높이 고정
            .padding(.horizontal, 16) // ✅ 그래프 내부 여백
            .background(
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 20)) // ✅ 둥근 모서리
            )
            .frame(width: geometry.size.width) // ✅ 전체 배경이 좌우 16 여백을 제외하고 가득 차도록 설정
        }
        .frame(height: 333) // ✅ 전체 뷰의 높이 고정
    }
}

// MARK: - Preview
struct VoteBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        VoteBarChartView(groupId: 1, voteId: 1)
            .background(.blue)
    }
}
