//
//  GroupVoteBeforeView.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import SwiftUI

struct GroupVoteBeforeView: View {
    
    // MARK: - 속성
    @EnvironmentObject var container: DIContainer
    
    @StateObject private var viewModel: GroupVoteBeforeViewModel
    @ObservedObject private var voteStatusViewModel: VoteStatusListViewModel
    
    @State private var voteId: Int = 1  // 기본값 설정

    init(container: DIContainer) {
        let viewModel = GroupVoteBeforeViewModel(container: container, voteId: 1)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._voteStatusViewModel = ObservedObject(initialValue: viewModel.voteStatusListViewModel) 
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            GroupNavigation(title: "투표하기") {
                container.navigationRouter.pop()
            }
            
            ScrollView {
                VStack(spacing: 25) {
                    // 투표 멤버 뷰
                    VotingBeforeMemberView(container: viewModel.container)
                        .padding(.top, 25)
                    
                    // 투표 현황 텍스트
                    sectionTitle("투표 현황")
                        .padding(.top, 39)
                    
                    if viewModel.isLoading {
                        ProgressView("데이터 로딩 중...")
                    } else if voteStatusViewModel.voteStatus.isEmpty {  
                        Text("현재 진행 중인 투표가 없습니다.")
                            .font(.body2)
                            .foregroundStyle(.g4)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .task {
                                viewModel.fetchCategories(groupId: 1)
                                print("🔍 최종 voteStatusListViewModel.voteStatus:", voteStatusViewModel.voteStatus)
                            }

                    } else {
                        VoteStatusListView(viewModel: voteStatusViewModel, voteId: voteId)  //  @ObservedObject 적용
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .task {
                                print("✅ [GroupVoteBeforeView] VoteStatusListView 렌더링됨! \(voteStatusViewModel.voteStatus)")
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color.bg2)
        }
        .padding(.bottom, 110)
        .task {
            viewModel.fetchCategories(groupId: 1)
            print("🔄 [GroupVoteBeforeView] fetchCategories 실행 완료")
            print("🔍 최종 voteStatusListViewModel.voteStatus:", voteStatusViewModel.voteStatus)

            // UI 업데이트 확인을 위해 0.1초 후 다시 출력
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                print("🔄 0.1초 후 최종 voteStatusListViewModel.voteStatus:", voteStatusViewModel.voteStatus)
            }
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
