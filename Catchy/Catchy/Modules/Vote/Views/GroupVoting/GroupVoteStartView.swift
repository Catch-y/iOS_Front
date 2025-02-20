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
    
    // MARK: - 초기화
    init(container: DIContainer) {
        self.container = container
        _viewModel = StateObject(wrappedValue: GroupVoteStartViewModel(container: container)) 
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
                .padding(.horizontal, 16)
            }
            .background(Color.bg2)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - 투표멤버뷰
    private var votingMemberView: some View {
        VotingMemberView(container: container)
            .padding(.top, 25)
    }
    
    // MARK: - 투표바차트
    private var voteBarChartView: some View {
        VoteBarChartView(groupId: viewModel.groupId, voteId: viewModel.voteId) //  ViewModel에서 groupId, voteId 가져오기
    }
    
    // MARK: - 투표상태
    private var votingStatusText: some View {
        Text("투표현황")
            .font(.Subtitle3)
            .foregroundStyle(.g5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
    }
    
    // MARK: - 투표 현황
    private var voteRankingView: some View {
        VoteRankView(voteId: viewModel.voteId) //  ViewModel에서 voteId 가져오기
            .background(Color.white)
            .mask(
                RoundedRectangle(cornerRadius: 30)
            )
            .padding(.bottom, 110)
    }
}

// MARK: - Preview
struct GroupVoteStartView_Previews: PreviewProvider {
    static var previews: some View {
        GroupVoteStartView(container: DIContainer()) 
    }
}
