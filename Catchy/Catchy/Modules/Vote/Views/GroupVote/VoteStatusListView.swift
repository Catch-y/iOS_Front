//
//  VoteStatusListView.swift
//  Catchy
//
//  Created by 임소은 on 2/6/25.
//

import SwiftUI

struct VoteStatusListView: View {
    @ObservedObject var viewModel: VoteStatusListViewModel  // ViewModel 바인딩
    var voteId: Int  // 투표 ID를 파라미터로 받기
    
    // MARK: - Body
    var body: some View {
        LazyVStack(spacing: 12) {
            if viewModel.isLoading {
                로딩뷰
            } else if viewModel.voteStatus.isEmpty {
                빈데이터뷰
            } else {
                투표현황리스트
            }

            // 선택된 카테고리 표시
            선택된카테고리뷰
        }
        .onAppear { viewModel.fetchCategories(voteId: voteId) }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding([.vertical], 46)
        .padding([.horizontal], 26)
    }

    // MARK: - 로딩 뷰
    private var 로딩뷰: some View {
        ProgressView("Loading...")
    }

    // MARK: - 빈 데이터 뷰
    private var 빈데이터뷰: some View {
        Text("투표 현황 데이터가 없습니다.")
            .font(.body3)
            .foregroundStyle(.g5)
    }

    // MARK: - 투표 현황 리스트
    private var 투표현황리스트: some View {
        ForEach(viewModel.voteStatus, id: \.categoryId) { status in
            HStack(spacing: 16) {
                순위서클(순위: status.categoryId)
                투표현황텍스트(상태: status)
            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.g3, lineWidth: 1))
            )
        }
    }

    // MARK: - 선택된 카테고리 뷰
    private var 선택된카테고리뷰: some View {
        VStack(alignment: .leading, spacing: 8) {

            ForEach(viewModel.selectedCategories, id: \.self) { category in
                HStack {
                    카테고리아이콘(이름: category.rawValue) // 카테고리 아이콘
                        .resizable()
                        .frame(width: 24, height: 24)

                    Text(category.rawValue) // 카테고리 이름
                        .font(.body2)
                        .foregroundStyle(.g7)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    // MARK: - 카테고리 아이콘 가져오기
    private func 카테고리아이콘(이름: String) -> Image {
        switch 이름 {
        case "휴식":
            return Icon.voteBreaks.image
        case "카페":
            return Icon.voteCafe.image
        case "문화생활":
            return Icon.voteCultureLife.image
        case "체험":
            return Icon.voteExperience.image
        case "음식점":
            return Icon.voteRestaurant.image
        case "스포츠":
            return Icon.voteSport.image
        case "주류":
            return Icon.voteBar.image
        default:
            return Icon.close.image // 기본 아이콘
        }
    }

    // MARK: - 순위 서클
    private func 순위서클(순위: Int) -> some View {
        Circle()
            .fill(Color.m3)
            .frame(width: 25, height: 25)
            .overlay(
                Text("\(순위)")
                    .font(.body1)
                    .foregroundStyle(.white)
            )
    }

    // MARK: - 투표 현황 텍스트
    private func 투표현황텍스트(상태: VoteCategoryResponse.CategoryDto) -> some View {
        HStack(spacing: 3) {
            Text(상태.name)
                .font(.Body1_2)
                .foregroundStyle(.g7)
            Text("0명")  // voteCount 대신 "0명" 표시
                .font(.body3)
                .foregroundStyle(.m5)
            Text("/ \(4)명")  // 예시로 4명으로 설정
                .font(.body3)
                .foregroundStyle(.g4)
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
