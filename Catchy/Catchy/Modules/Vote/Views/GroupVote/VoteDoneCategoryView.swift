//
//  VoteDoneCategoryView.swift
//  Catchy
//
//  Created by 임소은 on 2/5/25.
//

import SwiftUI

struct VoteDoneCategoryView: View {
    // MARK: - 속성
    let groupId: Int
    let voteId: Int
    let onBackButtonTap: () -> Void
    @StateObject private var viewModel: VoteDoneCategoryViewModel

    // MARK: - 초기화
    init(container: DIContainer, groupId: Int, voteId: Int, onBackButtonTap: @escaping () -> Void = {}) {
        self.groupId = groupId
        self.voteId = voteId
        self.onBackButtonTap = onBackButtonTap
        _viewModel = StateObject(wrappedValue: VoteDoneCategoryViewModel(container: container))
        setupNavigationBarAppearance()
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            ScrollView {
                content
                    .padding(.horizontal, 16)
            }
        }
        .padding(.bottom, 110)
        .onAppear {
            viewModel.fetchCategories(groupId: groupId, voteId: voteId)
        }
    }
}

// MARK: - Subviews
extension VoteDoneCategoryView {
    private var navigationBar: some View {
        GroupNavigation(title: "투표 완료", onBackButtonTap: onBackButtonTap)
    }

    private var content: some View {
        VStack(spacing: 0) {
            headerText
                .padding(.top, 39)
                .padding(.bottom, 44)

            if viewModel.isLoading {
                ProgressView("로딩 중...")
            } else if viewModel.categories.isEmpty {
                Text("카테고리가 없습니다.")
                    .font(.body2)
                    .foregroundStyle(.g4)
            } else {
                categoryList
            }
        }
        .padding(.horizontal, 16)
        .background(Color.white)
    }

    private var headerText: some View {
        VStack(alignment: .leading) {
            Text(viewModel.groupLocation.isEmpty ? "무슨구 무슨동" : viewModel.groupLocation) // ✅ 기본값 설정
                .font(.Subtitle2)
                .foregroundStyle(.m6)
            Text("만날만한 장소를 알려드릴게요")
                .font(.Subtitle2)
                .foregroundStyle(.g7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }


    private var categoryList: some View {
        VStack(spacing: 50) {
            ForEach(viewModel.categories, id: \.category) { category in
                categoryRow(name: category.category, count: category.count, icon: getIcon(for: category.category))
            }
        }
    }

    private func categoryRow(name: String, count: Int, icon: Image) -> some View {
        HStack(spacing: 8) {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundStyle(.m5)

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.Subtitle3)
                    .foregroundStyle(.g7)
                Text("\(count)개")
                    .font(.caption)
                    .foregroundStyle(.g4)
            }

            Spacer()

            Button(action: {
                print("\(name) 버튼 클릭됨")
            }) {
                Icon.rightChevron.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.g4)
            }
            .padding(.trailing, 16)
        }
    }

    private func getIcon(for categoryName: String) -> Image {
        switch categoryName {
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
            return Icon.rightChevron.image //기본이미지 넣어둔것
        }
    }
}

// MARK: - Helpers
extension VoteDoneCategoryView {
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - Preview
struct VoteDoneCategoryView_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            NavigationView {
                VoteDoneCategoryView(container: DIContainer(), groupId: 1, voteId: 123) {
                    print("뒤로가기 버튼 클릭")
                }
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
