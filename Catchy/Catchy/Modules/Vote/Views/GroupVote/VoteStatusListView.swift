//
//  VoteStatusListView.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import SwiftUI

struct VoteStatusListView: View {
    @ObservedObject var viewModel: VoteStatusListViewModel
    var voteId: Int  // 투표 ID를 파라미터로 받기

    // MARK: - Body
    var body: some View {
        LazyVStack(spacing: 12) {
            if viewModel.isLoading {
                loadingView
            } else if viewModel.voteStatus.isEmpty {
                emptyDataView
            } else {
                voteStatusList
            }
        }
        .task {
            viewModel.fetchCategories(groupId: 1, voteId: voteId) //
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.vertical, 46)
        .padding(.horizontal, 26)
    }

    // MARK: - Loading View
    private var loadingView: some View {
        ProgressView("Loading...")
    }

    // MARK: - Empty Data View
    private var emptyDataView: some View {
        Text("투표 현황 데이터가 없습니다.")
            .font(.body3)
            .foregroundStyle(.g5)
    }

    // MARK: - Vote Status List
    private var voteStatusList: some View {
        ForEach(viewModel.voteStatus, id: \.category) { status in // category 기반으로 수정
            HStack(spacing: 16) {
                rankingCircle(rank: status.count) //  count 기반으로 수정
                voteStatusText(status: status)
            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.g3, lineWidth: 1))
            )
        }
    }

    // MARK: - Ranking Circle
    private func rankingCircle(rank: Int) -> some View {
        Circle()
            .fill(Color.m3)
            .frame(width: 25, height: 25)
            .overlay(
                Text("\(rank)")
                    .font(.body1)
                    .foregroundStyle(.white)
            )
    }

    // MARK: - Vote Status Text
    private func voteStatusText(status: CategoryResultData) -> some View {
        HStack(spacing: 3) {
            Text(status.category) // ✅ 변경된 모델 사용
                .font(.Body1_2)
                .foregroundStyle(.g7)
            Text("\(status.count)명")  // ✅ count 값 적용
                .font(.body3)
                .foregroundStyle(.m5)
            Spacer()
        }
    }
}

// MARK: - Preview
struct VoteStatusListView_Previews: PreviewProvider {
    static var previews: some View {
        VoteStatusListView(viewModel: VoteStatusListViewModel(container: DIContainer()), voteId: 1)
    }
}
