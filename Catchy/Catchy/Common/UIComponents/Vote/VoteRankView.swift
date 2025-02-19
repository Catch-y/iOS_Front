//
//  VoteRankView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI
import Kingfisher

struct VoteRankView: View {
    @StateObject private var viewModel: VoteRankViewModel

    // MARK: - 초기화
    init(voteId: Int) {
        _viewModel = StateObject(wrappedValue: VoteRankViewModel(voteId: voteId))
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            categoryTabs
                .padding(.bottom, 28)
                .padding(.top, 32)

            if viewModel.ranks.count > 3 {
                rankRows()
                    .padding(.bottom, 30)
            }
        }
        .padding(.horizontal, 16)
    }

    // MARK: - 1~3위 (막대그래프 형식)
    private var categoryTabs: some View {
        HStack(alignment: .bottom, spacing: 6) {
            Spacer()
            
            if viewModel.ranks.indices.contains(1) {
                let rankData = viewModel.ranks[1]
                categoryTabItem(for: rankData, category: .voteCafe, rank: 2, backgroundColor: .g3)
            }

            if viewModel.ranks.indices.contains(0) {
                let rankData = viewModel.ranks[0]
                categoryTabItem(for: rankData, category: .voteBreaks, rank: 1, backgroundColor: Color.m5)
                    .alignmentGuide(.bottom) { $0[.bottom] }
            }

            if viewModel.ranks.indices.contains(2) {
                let rankData = viewModel.ranks[2]
                categoryTabItem(for: rankData, category: .voteCultureLife, rank: 3, backgroundColor: .g3)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private func categoryTabItem(
        for rankData: (name: String, count: Int, totalMembers: Int, avatars: [String]),
        category: VoteCategory,
        rank: Int,
        backgroundColor: Color
    ) -> some View {
        let backgroundHeight: CGFloat = {
            switch rank {
            case 1: return 80
            case 2: return 50
            case 3: return 40
            default: return 40
            }
        }()

        return VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 55, height: 55)

                category.icon.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(rank == 1 ? Color.m4 : .gray)
            }

            Text(rankData.name)
                .font(.body3)
                .foregroundStyle(rank == 1 ? .m5 : .gray)
                .padding(.bottom, 12)

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor)
                    .frame(width: 100, height: backgroundHeight)

                VStack {
                    Spacer()
                    Text("\(rank)")
                        .font(.body3)
                        .foregroundStyle(.white)
                        .padding(.bottom, 5)
                }
                .frame(height: backgroundHeight, alignment: .bottom)
            }
        }
    }

    private func rankRows() -> some View {
        VStack(spacing: 12) {
            ForEach(viewModel.ranks.indices.dropFirst(3).prefix(4), id: \.self) { index in
                rankRow(for: viewModel.ranks[index], rankIndex: index + 1)
            }
        }
    }

    private func rankRow(for rankData: (name: String, count: Int, totalMembers: Int, avatars: [String]), rankIndex: Int) -> some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.m3)
                .frame(width: 25, height: 25)
                .overlay(
                    Text("\(rankIndex)")
                        .font(.body3)
                        .foregroundStyle(Color.white)
                )

            HStack(spacing: 13) {
                Text(rankData.name)
                    .font(.Body1_2)
                    .foregroundStyle(.g7)

                Text("\(rankData.count)명 / \(rankData.totalMembers)명 참여")
                    .font(.caption)
                    .foregroundStyle(.g5)
            }

            Spacer()

            // Kingfisher를 이용한 프로필 이미지 로딩
            HStack(spacing: -8) {
                ForEach(rankData.avatars.prefix(4), id: \.self) { avatarURL in
                    ZStack {
                        Circle()
                            .fill(Color.bg1)
                            .frame(width: 28, height: 28)

                        KFImage(URL(string: avatarURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 28, height: 28)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 1)
                            )
                    }
                }
            }

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.g3, lineWidth: 1)
        )
    }
}

// MARK: - VoteCategory & Icon 연동
enum VoteCategory: String {
    case voteBreaks = "voteBreaks"
    case voteCafe = "voteCafe"
    case voteCultureLife = "voteCultureLife"
    case voteExperience = "voteExperience"
    case voteRestaurant = "voteRestaurant"
    case voteSport = "voteSport"
    case voteBar = "voteBar"

    var icon: Icon {
        return Icon(rawValue: self.rawValue) ?? .voteBreaks
    }
}

// MARK: - Preview
struct VoteRankView_Previews: PreviewProvider {
    static var previews: some View {
        VoteRankView(voteId: 1)
    }
}
