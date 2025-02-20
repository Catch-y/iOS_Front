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

    //  카테고리 고정 순서
    private let fixedCategories: [(name: String, color: Color)] = [
        ("카페", .cafe),
        ("주류", .bar),
        ("음식점", .restaurant),
        ("체험", .experience),
        ("문화생활", .culturaLife),
        ("스포츠", .sport),
        ("휴식", .rest)
    ]
    
    // MARK: - Initializer
    init(groupId: Int, voteId: Int) {
        _viewModel = StateObject(wrappedValue: VoteBarChartViewModel(groupId: groupId, voteId: voteId))
    }

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() // 상단 여백
                
                HStack(alignment: .bottom, spacing: 8) {
                    Spacer(minLength: 0) //
                    ForEach(fixedCategories, id: \.name) { category in
                        let option = viewModel.options.first { $0.name == category.name }
                        VStack(spacing: 10) {
                            // 투표값이 없어도 최소 높이 유지
                            RoundedRectangle(cornerRadius: 10)
                                .fill(category.color)
                                .frame(
                                    width: 40,
                                    height: max(CGFloat(option?.count ?? 0) * 15, 4) //  최소 높이 4
                                )
                            
                            // 항상 표시되는 카테고리 텍스트
                            Text(category.name)
                                .lineLimit(1)
                                .font(.body3)
                                .multilineTextAlignment(.center)
                                .frame(width: 42)
                                .foregroundStyle(.g5)
                        }
                    }
                    Spacer(minLength: 0) // 막대그래프 중앙 정렬
                }
                .padding(.bottom, 36)
                .padding(.top, 33)
            }
            .frame(height: 333) //  흰색 배경 높이 고정
            
            .background(
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
            
            )
            
           
        }
        .frame(height: 333) //  전체 뷰의 높이 고정
        
    }
}

// MARK: - Preview
struct VoteBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        VoteBarChartView(groupId: 1, voteId: 1)
            .background(.blue)
    }
}
