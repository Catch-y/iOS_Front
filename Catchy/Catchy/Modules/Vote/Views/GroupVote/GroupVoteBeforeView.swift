//
//  GroupVoteBeforeView.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import SwiftUI

struct GroupVoteBeforeView: View {
    
    // MARK: - 속성
    @StateObject private var viewModel: VoteStatusListViewModel // VoteStatusListViewModel을 사용

    init(container: DIContainer) {
        // DIContainer를 통해 ViewModel 초기화
        self._viewModel = StateObject(wrappedValue: VoteStatusListViewModel(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            GroupNavigation(title: "투표하기") {
                print("뒤로가기 클릭")
            }
            
            ScrollView {
                VStack(spacing: 25) {
                    // 투표 멤버 뷰
                    VotingBeforeMemberView(container: viewModel.container)
                        .padding(.top, 25)
                    
                    // 투표 현황 텍스트
                    sectionTitle("투표 현황")
                        .padding(.top, 39)
                    
                    // 투표 현황 리스트
                    VoteStatusListView(viewModel: viewModel, voteId: 123) // 동일한 ViewModel 사용
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal, 16)
            }
            .background(Color.bg2)
        }
        .padding(.bottom, 110)
        .onAppear {
            viewModel.fetchCategories(voteId: 123)  // 예시 voteId 값으로 데이터 로드
        }
    }
    
    // MARK: - Subviews
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.Subtitle3)
            .foregroundStyle(.g5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
    }
}

// MARK: - Preview
struct GroupVoteBeforeView_Previews: PreviewProvider {
    static var previews: some View {
        GroupVoteBeforeView(container: DIContainer())
    }
}
