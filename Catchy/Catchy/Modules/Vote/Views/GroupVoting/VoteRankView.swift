import SwiftUI

struct VoteRankView: View {
    @StateObject private var viewModel: VoteRankViewModel

    // MARK: - 초기화 
    init(groupId: Int, voteId: Int) {
        _viewModel = StateObject(wrappedValue: VoteRankViewModel(groupId: groupId, voteId: voteId))
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            // 카테고리 탭
            categoryTabs
                .padding(.bottom, 28)
                .padding(.top, 32)

            // 3위까지 순위 표시
            if viewModel.ranks.isEmpty {
                Text("순위 데이터가 없습니다.")
                    .font(.body)
                    .foregroundStyle(.g6)
            } else {
                ForEach(viewModel.ranks.prefix(3).indices, id: \.self) { index in
                    rankRow(for: viewModel.ranks[index], rankIndex: index + 1)
                }

                // 4~7위 표시
                rankRows()
                    .padding(.bottom , 30)
            }
        }
        .padding(.horizontal, 16)
    }

    // MARK: - 카테고리 탭
    private var categoryTabs: some View {
        HStack(alignment: .bottom, spacing: 16) {
            // 2등
            if viewModel.ranks.indices.contains(1) {
                let rankData = viewModel.ranks[1]
                categoryTabItem(for: rankData, rank: 2, isCenter: false)
            }

            // 1등
            if viewModel.ranks.indices.contains(0) {
                let rankData = viewModel.ranks[0]
                categoryTabItem(for: rankData, rank: 1, isCenter: true)
            }

            // 3등
            if viewModel.ranks.indices.contains(2) {
                let rankData = viewModel.ranks[2]
                categoryTabItem(for: rankData, rank: 3, isCenter: false)
            }
        }
        .frame(maxWidth: .infinity) // 전체 너비 확보
        .padding(.horizontal, 16)
        .alignmentGuide(.bottom) { d in d[.bottom] } // 하단 정렬
    }

    // MARK: - 카테고리 탭 아이템
    private func categoryTabItem(for rankData: (name: String, count: Int, totalCount: Int, avatars: [String]), rank: Int, isCenter: Bool) -> some View {
        let backgroundHeight: CGFloat = isCenter ? 80 : 40 // 가운데 항목의 높이만 다르게 설정

        return VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isCenter ? Color.m4 : Color.gray.opacity(0.2))
                    .frame(width: isCenter ? 45 : 45, height: isCenter ? 45 : 45) // 아이콘 크기는 같게

                Image(systemName: "leaf") // 아이콘 예시
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }

            Text(rankData.name)
                .font(isCenter ? .body.bold() : .caption)
                .foregroundStyle(isCenter ? .m4 : .g6)
                .padding(.bottom, 4)

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isCenter ? Color.m4 : Color.gray.opacity(0.2))
                    .frame(width: isCenter ? 80 : 60, height: backgroundHeight) // 하단 직사각형 크기
                Text("\(rank)")
                    .font(.body3)
                    .foregroundStyle(.white)
            }
        }
        .frame(maxHeight: 140) // 하단 정렬을 위한 고정 높이
    }

    
    // MARK: - 순위 행
    private func rankRow(for rankData: (name: String, count: Int, totalCount: Int, avatars: [String]), rankIndex: Int) -> some View {
        HStack(spacing: 12) {
            // 순위와 이름
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.pink.opacity(0.2))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text("\(rankIndex)")
                            .font(.body3)
                            .foregroundStyle(.m4)
                    )
                HStack(spacing: 13) {
                    Text(rankData.name)
                        .font(.Body1_2)
                        .foregroundStyle(.g7)
                    Text("\(rankData.count)명 / \(rankData.totalCount)명 투표")
                        .font(.caption)
                        .foregroundStyle(.g5)
                }
            }

            Spacer()

            // 아바타 리스트
            HStack(spacing: -8) {
                ForEach(rankData.avatars.prefix(4), id: \.self) { avatar in
                    AsyncImage(url: URL(string: avatar)) { image in
                        image.resizable()
                    } placeholder: {
                        Circle()
                            .fill(Color.g3)
                    }
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
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
                .stroke(Color.g3, lineWidth: 1) // 테두리 추가
        )
    }

    // MARK: - 순위 행 표시 (4~7위)
    private func rankRows() -> some View {
        VStack(spacing: 16) {
            ForEach(viewModel.ranks.indices.dropFirst(3).prefix(4), id: \.self) { index in
                rankRow(for: viewModel.ranks[index], rankIndex: index + 1)
            }
        }
    }
}

// MARK: - Preview
struct VoteRankView_Previews: PreviewProvider {
    static var previews: some View {
        VoteRankView(groupId: 1, voteId: 1)
    }
}
