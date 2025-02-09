//
//  VoteBarChartView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//


import SwiftUI

struct VoteBarChartView: View {
    
    // TODO: - 항상 텍스트 나오도록하기
    
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
                    
                    HStack(alignment: .bottom, spacing: 16) { // 그래프 간 간격 16
                        ForEach(viewModel.options) { option in
                            VStack(spacing: 10) {
                                // 막대 그래프
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(option.color)
                                    .frame(
                                        width: 40,
                                        height: max(CGFloat(option.count) * 15, 8) // 최소 높이 10
                                    )
                                
                                // 카테고리 텍스트
                                Text(option.name)
                                    .lineLimit(1) // 한 줄 제한
                                    .font(.body3)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 40) // 막대와 텍스트 정렬
                                    .foregroundStyle(.g5)
                            }
                        }
                    }
                    .padding(.horizontal, 16) // 그래프 내부 여백
                    .padding(.bottom, 36)
                    .padding(.top, 33)
                }
                .frame(height: 333) // 흰색 프레임 높이 고정
                .background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 20)) // 둥근 모서리
                )
                .frame(width: geometry.size.width - 32) // ✅ GeometryReader로 좌우 16 여백 설정
            }
            .frame(height: 333) // 전체 뷰의 높이 고정
        }
    }

// MARK: - Preview
struct VoteBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        VoteBarChartView(groupId: 1, voteId: 1)
    }
}

