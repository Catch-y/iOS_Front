//
//  GroupVoteView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI

struct GroupVoteStartView: View {
    
    // MARK: - 속성
    @StateObject private var viewModel: GroupVoteStartViewModel
    private let container: DIContainer
    
    // MARK: - 초기화 메서드
    init(container: DIContainer, groupId: Int, voteId: Int) {
        self.container = container
        self._viewModel = StateObject(wrappedValue: GroupVoteStartViewModel(container: container, groupId: groupId, voteId: voteId))
    }
    
    // MARK: - body
    var body: some View {
        VStack(spacing: 0) {
            
            // 네비게이션 바
            GroupNavigation(title: "투표하기") {
                print("뒤로가기 클릭")
            }
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    // 투표 멤버 뷰
                    투표멤버뷰
                    
                    // 투표 바 차트 뷰
                    투표바차트뷰
                    
                    // 투표 현황 제목
                    투표현황텍스트
                    
                    // 투표 순위 뷰
                    투표순위뷰
                }
            }
            .background(Color.bg2)
        }
    }
    
    // MARK: - 투표 멤버 뷰
    private var 투표멤버뷰: some View {
        VotingMemberView(container: container)
            .padding(.top, 25)
    }
    
    // MARK: - 투표 바 차트 뷰
    private var 투표바차트뷰: some View {
        VoteBarChartView(groupId: viewModel.groupId, voteId: viewModel.voteId)
    }
    
    // MARK: - 투표 현황 텍스트
    private var 투표현황텍스트: some View {
        Text("투표현황")
            .font(.Subtitle3)
            .foregroundStyle(.g5)
            .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬
            .padding(.leading, 16) // 왼쪽에서 16 떨어짐
    }
    
    // MARK: - 투표 순위 뷰
    private var 투표순위뷰: some View {
        VoteRankView(groupId: viewModel.groupId, voteId: 1)
            .background(Color.white)
            .mask(
                RoundedRectangle(cornerRadius: 30)
            )
            .padding(.bottom, 110)
            .padding(.horizontal, 16)
    }
}

// MARK: - Preview
struct GroupVoteStartView_Previews: PreviewProvider {
    static var previews: some View {
        GroupVoteStartView(container: DIContainer(), groupId: 1, voteId: 1)
    }
}
