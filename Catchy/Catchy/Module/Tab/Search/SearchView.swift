//
//  SearchView.swift
//  Catchy
//
//  Created by euijjang97 on 12/4/25.
//

import SwiftUI

struct SearchView: View, Equatable {
    
    // MARK: - Property
    @State var viewModel: SearchViewModel
    @FocusState var searchField: Bool
    @Namespace var namespace
    @Environment(\.isSearching) private var isSearching // 검색 중 상태 감지
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.viewModel.searchText == rhs.viewModel.searchText
    }
    
    // MARK: - Constant
    fileprivate enum SearchConstants {
        static let titleSpacing: CGFloat = 8
        static let lineSpacing: CGFloat = 5
        static let flowSpacing: CGFloat = 10
        static let buttonRadius: CGFloat = 15
        static let bottomSpacing: CGFloat = 14
        static let mainSpacing: CGFloat = 30
        static let cardListPadding: EdgeInsets = .init(top: 20, leading: 16, bottom: 20, trailing: 16)
        static let noResultText: (String, String) = ("검색어와 일치하는 내용이 없어요", "확인 후 다시 검색해주세요")
        static let mainTitle: String = "어떤 장소를 찾고 계신가요?"
        static let subTitle: String = "Catch:y에서 알려드릴게요"
        static let recentTitle: String = "최근 검색어"
        static let allClearTitle: String = "지우기"
    }
    
    // MARK: - Init
    init() {
        self._viewModel = .init(wrappedValue: .init())
    }
    
    // MARK: - Body
    var body: some View {
          VStack(alignment: .leading, spacing: spacing) {
              // 검색 전 상태 (타이틀 표시)
              if !isSearching && viewModel.searchText.isEmpty {
                  Spacer()
                  topContent
                      .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
              }

              // 검색 필드 (항상 표시)
              middleContent
                  .padding(.horizontal, DefaultConstants.defaultSafeHorizon)

              // 검색 결과 or 최근 검색어
              if viewModel.searchText.isEmpty {
                  Spacer()
                  if !viewModel.recentSearch.isEmpty {
                      bottomContent
                          .padding(.horizontal, DefaultConstants.defaultSafeHorizon)
                  }
              } else {
                  placeList
              }
          }
          .animation(.spring(), value: viewModel.recentSearch)
          .animation(.spring(), value: viewModel.searchText)
          .task {
              await viewModel.fetchingData()
          }
      }
    
    private var spacing: CGFloat {
        return viewModel.searchText.isEmpty ? SearchConstants.mainSpacing : SearchConstants.lineSpacing
    }
    
    // MARK: - Top
    /// 상단 타이틀 + 상단 서브 타이틀
    private var topContent: some View {
        VStack(alignment: .leading, spacing: SearchConstants.titleSpacing, content: {
            Text(SearchConstants.mainTitle.highlight([("장소", .m6)]))
                .font(.headline3)
                .foregroundStyle(Color(uiColor: .label))
                .lineSpacing(SearchConstants.lineSpacing)
            
            Text(SearchConstants.subTitle)
                .font(.body1_2)
                .foregroundStyle(.g5)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .transition(.opacity)
    }
    
    // MARK: - Middle
    private var middleContent: some View {
        TextField("", text: $viewModel.searchText, prompt: placeholder)
            .searchTextFieldStyle(text: $viewModel.searchText, onSearch: {
                Task {
                    await viewModel.saveSearch()
                }
            })
            .font(.body1)
            .foregroundStyle(.g6)
            .onSubmit(of: .search) {
                Task {
                    await viewModel.saveSearch()
                }
            }
            .keyboardType(.default)
            .textInputAutocapitalization(.never)
            .focused($searchField)
    }
    
    private var placeholder: Text {
        Text("원하는 장소나 카테고리를 검색해보세요")
            .font(.body2)
            .foregroundStyle(.g3)
    }
    // MARK: - Bottom
    /// 하단 최근 검색어 컨텐츠
    private var bottomContent: some View {
        VStack(alignment: .leading, spacing: SearchConstants.bottomSpacing, content: {
            recentKeyTitle
            recentKeyword
        })
    }
    
    /// 하단 최근 검색어
    private var recentKeyword: some View {
        FlowLayout(spacing: SearchConstants.flowSpacing) {
            ForEach(viewModel.recentSearch, id: \.self) { keyword in
                SearchChip(text: keyword, action: {
                    viewModel.searchText = keyword
                }, delete: {
                    Task {
                        await viewModel.removeWord(keyword)
                    }
                })
            }
        }
    }
    
    /// 하단 최근 검색어 타이틀
    private var recentKeyTitle: some View {
        HStack {
            Text(SearchConstants.recentTitle)
                .font(.body2)
                .foregroundStyle(.g5)
            
            Spacer()
            
            Button(SearchConstants.allClearTitle, action: {
                Task {
                    await viewModel.clearAll()
                }
            })
            .font(.caption1)
            .foregroundStyle(.g4)
        }
    }
    
    // MARK: - PlaceCardContent
    @ViewBuilder
    private var placeList: some View {
        if viewModel.searchData.isEmpty {
            Spacer()
            emptyView
        } else {
            cardSearchView
        }
    }
    
    /// 검색 데이터 존재하지 않을 경우
    private var emptyView: some View {
        VStack(alignment: .center, spacing: .zero, content: {
            Image(.emptyResult)
                .fixedSize()
            
            Text(SearchConstants.noResultText.0)
                .font(.subtitle2)
                .foregroundStyle(Color.g7)
                .padding(.top, 15)
            
            Text(SearchConstants.noResultText.1)
                .font(.body1_2)
                .foregroundStyle(Color.g4)
            
            Spacer()
        })
        .transition(.opacity)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    /// 검색 데이터 존재할 경우
    private var cardSearchView: some View {
        List {
            ForEach(viewModel.searchData, id: \.id) { data in
                SearchRecommendCard(data: data)
            }
            .listRowInsets(SearchConstants.cardListPadding)
            .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in 0 })
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SearchView()
}
