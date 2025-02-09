//
//  VoteDoneCategoryView.swift
//  Catchy
//
//  Created by 임소은 on 2/5/25.
//

import SwiftUI

struct VoteDoneCategoryView: View {
    // MARK: - 속성
    let onBackButtonTap: () -> Void
    @StateObject private var viewModel: VoteDoneCategoryViewModel = VoteDoneCategoryViewModel(container: DIContainer())

    // MARK: - 초기화 
    init(onBackButtonTap: @escaping () -> Void = {}) {
        self.onBackButtonTap = onBackButtonTap
        setupNavigationBarAppearance()
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            ScrollView {
                content
                    .padding(.horizontal ,16)
            }
        }
        .padding(.bottom, 110)
        .onAppear {
            viewModel.fetchCategories(voteId: 123) // 실제 voteId로 API 호출
        }
    }
}

// MARK: - Subviews
extension VoteDoneCategoryView {
    private var navigationBar: some View {
        GroupNavigation(title: "투표하기", onBackButtonTap: onBackButtonTap)
    }

    private var content: some View {
        VStack(spacing: 0) {
            headerText
                .padding(.top, 39)
                .padding(.bottom, 44)

            if viewModel.isLoading {
                ProgressView("Loading...")
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
            Text("서울시 용산구에서")
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
            ForEach(viewModel.categories, id: \ .categoryId) { category in
                categoryRow(index: category.categoryId, name: category.name, icon: getIcon(for: category.name))
            }
        }
    }

    private func categoryRow(index: Int, name: String, icon: Image) -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(Color.white)
                .frame(width: 26, height: 26)
                .s3i()
                .overlay(
                    Text("\(index)")
                        .font(.Subtitle3)
                        .foregroundStyle(.m5)
                )
                .padding(.trailing, 10)

            icon
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundStyle(.m5)
           
                Text(name)
                    .font(.Subtitle3)
                    .foregroundStyle(.g7)
                Text("130개")
                    .font(.caption)
                    .foregroundStyle(.g4)

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
            return Icon.rightChevron.image // 기본 아이콘 설정
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
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \ .self) { deviceName in
            NavigationView {
                VoteDoneCategoryView {
                    print("뒤로가기 버튼 클릭")
                }
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
