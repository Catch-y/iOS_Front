//
//  VotePopupView.swift
//  Catchy
//
//  Created by 임소은 on 2/2/25.
//

import SwiftUI

struct VotePopupView: View {
    var dismissAction: () -> Void // 외부에서 닫기 동작 전달
    var onComplete: ([String]) -> Void // 선택된 값 전달

    @State private var selectedCategories: [String] = [] // 선택된 카테고리 관리

    var body: some View {
        popupBackground {
            VStack(spacing: 8) {
                headerView
                titleView
                categoryListView
                    .padding()
                completeButton
            }
            .padding()
        }
    }
}

// MARK: - Subviews
extension VotePopupView {
    
    // MARK: - 팝업 배경
    private func popupBackground<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: .infinity, height: 783) // 팝업 크기
                .clipShape(RoundedRectangle(cornerRadius: 20))
            content()
        }
    }

    // MARK: - 헤더 (닫기 버튼)
    private var headerView: some View {
        HStack {
            Spacer()
            Button(action: dismissAction) {
                Icon.close.image
            }
            .padding(.leading ,16)
            .padding(.top ,30)
        }
    }

    // MARK: - 제목
    private var titleView: some View {
        VStack(spacing: 8) {
            HStack(spacing: 2) {
                Text("코스에 추가")
                    .font(.Subtitle3)
                    .foregroundStyle(.m4)
                Text("하고 싶은")
                    .font(.Subtitle3)
                    .foregroundStyle(.g7)
            }

            Text("카테고리에 투표해주세요!")
                .font(.Subtitle3)
                .foregroundStyle(.g7)
            
            Text("중복투표도 가능합니다!")
                .font(.body3)
                .foregroundStyle(.g4)
        }
        .multilineTextAlignment(.center)
    }

    // MARK: - 카테고리 리스트
    private var categoryListView: some View {
        VStack(spacing: 36) {
            categoryRow(index: 1, name: "휴식", icon: Icon.voteBreaks.image)
            categoryRow(index: 2, name: "카페", icon: Icon.voteCafe.image)
            categoryRow(index: 3, name: "문화생활", icon: Icon.voteCultureLife.image)
            categoryRow(index: 4, name: "체험", icon: Icon.voteExperience.image)
            categoryRow(index: 5, name: "음식점", icon: Icon.voteRestaurant.image)
            categoryRow(index: 6, name: "스포츠", icon: Icon.voteSport.image)
            categoryRow(index: 7, name: "주류", icon: Icon.voteBar.image)
        }
    }

    // MARK: - 투표 완료 버튼
    private var completeButton: some View {
        Button(action: {
            onComplete(selectedCategories)
            dismissAction()
        }) {
            Text("투표 완료")
                .font(.Subtitle3)
                .foregroundStyle(selectedCategories.isEmpty ? .g5 : .white)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(selectedCategories.isEmpty ? Color.g2 : Color.m4)
                )
        }
        .padding(.horizontal, 16)
        .disabled(selectedCategories.isEmpty)
    }

    // MARK: - 카테고리 행
    private func categoryRow(index: Int, name: String, icon: Image) -> some View {
        VStack(spacing: 18) {
            HStack {
                icon // 아이콘 표시
                    .resizable()
                    .frame(width: 35, height: 35)

                Text(name)
                    .font(.Body1_2)
                    .foregroundStyle(.g6)

                Spacer()

                Button(action: { toggleSelection(for: name) }) {
                    if selectedCategories.contains(name) {
                        Icon.allSelectCheckBtn.image
                            .resizable()
                            .frame(width: 24, height: 24)
                    } else {
                        Icon.allCheckBtn.image
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .frame(width: 24, height: 24)
            }

            Divider() // 구분선 추가
                .background(Color.g3)
                .padding(.horizontal, 8)
        }
    }
}

// MARK: - 선택 상태 토글
extension VotePopupView {
    private func toggleSelection(for category: String) {
        if let index = selectedCategories.firstIndex(of: category) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.append(category)
        }
    }
}

// MARK: - Preview
struct VotePopupView_Previews: PreviewProvider {
    static var previews: some View {
        VotePopupView(
            dismissAction: {},
            onComplete: { selectedCategories in
                print("선택된 카테고리: \(selectedCategories)")
            }
        )
    }
}
