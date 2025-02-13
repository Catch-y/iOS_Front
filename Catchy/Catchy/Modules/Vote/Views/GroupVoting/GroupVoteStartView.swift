//
//  GroupVoteStartView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI

struct GroupVoteStartView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: GroupVoteStartViewModel
    private let container: DIContainer
    
    // MARK: - Initializer
    init(container: DIContainer, groupId: Int, voteId: Int) {
        self.container = container
        self._viewModel = StateObject(wrappedValue: GroupVoteStartViewModel(container: container, groupId: groupId, voteId: voteId))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            
            GroupNavigation(title: "투표하기") {
                print("뒤로가기버튼클릭")
            }
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    votingMemberView

                    voteBarChartView

                    votingStatusText

                    voteRankingView
                }
            }
            .background(Color.bg2)
        }
    }
    
    // MARK: - 투표멤버뷰
    private var votingMemberView: some View {
        VotingMemberView(container: container)
            .padding(.top, 25)
    }
    
    // MARK: - 투표바차트
    private var voteBarChartView: some View {
        VoteBarChartView(groupId: viewModel.groupId, voteId: viewModel.voteId)
    }
    
    // MARK: - 투표상태
    private var votingStatusText: some View {
        Text("투표현황")
            .font(.Subtitle3)
            .foregroundStyle(.g5)
            .frame(maxWidth: .infinity, alignment: .leading) // Left align
            .padding(.leading, 16) // 16 padding from left
    }
    
    // MARK: - 투표 현황
    private var voteRankingView: some View {
        VoteRankView(groupId: viewModel.groupId, voteId: viewModel.voteId)
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
