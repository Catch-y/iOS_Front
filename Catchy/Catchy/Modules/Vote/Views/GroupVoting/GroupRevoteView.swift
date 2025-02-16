//
//  GroupRevoteView.swift
//  Catchy
//
//  Created by 임소은 on 2/17/25.
//

import SwiftUI

struct GroupRevoteView: View {
    
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
                    
                    retryVoteButton

                    voteBarChartView

                    votingStatusText

                    voteRankingView
                }
                .padding(.horizontal, 16)
            }
            .background(Color.bg2)
        }
    }
    
    // MARK: - 투표멤버뷰
    private var votingMemberView: some View {
        VotingMemberView(container: container)
            .padding(.top, 25)
    }
    
    // MARK: - 카테고리 다시 투표하기 버튼
       private var retryVoteButton: some View {
           Button(action: {
               print("카테고리 다시 투표하기 버튼 클릭")
           }) {
               Text("카테고리 다시 투표하기")
                   .font(.body2)
                   .foregroundStyle(.m5)
                   .frame(height: 60)
                   .frame(maxWidth: .infinity)
                   .background(Color.white)
                   .clipShape(RoundedRectangle(cornerRadius: 32))
                   .overlay(
                       RoundedRectangle(cornerRadius: 32)
                           .stroke(Color.m5, lineWidth: 1
                   ))
                       
           }
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
            
    }
}

// MARK: - Preview
struct GroupRevoteView_Previews: PreviewProvider {
    static var previews: some View {
        GroupRevoteView(container: DIContainer(), groupId: 1, voteId: 1)
    }
}
