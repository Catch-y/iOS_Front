import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel(container: container))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            CustomNavigation(
                action: { viewModel.container.navigationRouter.pop() },
                title: nil,
                rightNaviIcon: nil
            )
            .padding(.horizontal, 16)
            
            if viewModel.searchKeyword.isEmpty {
                Spacer().frame(height: 95)
                topTitle
                    .padding(.leading, 25)
                    .transition(.opacity)
            }
            
            CustomTextField(
                text: $viewModel.searchKeyword,
                onSubmit: { viewModel.saveKeyword(viewModel.searchKeyword) },
                searchTextField: .searchView
            )
            .padding(.top, 20)
            .padding(.horizontal, 16)
            .animation(.easeInOut(duration: 0.5), value: viewModel.searchKeyword)
            .submitScope()
            
            if !viewModel.recentWords.isEmpty && viewModel.searchKeyword.isEmpty {
                recentKeywords
                    .padding(.top, 38)
                    .padding(.leading, 25)
                    .padding(.trailing, 20)
            }
            
            Spacer()
            
            if viewModel.showResult && !viewModel.searchKeyword.isEmpty {
                if !viewModel.flatSearchData.isEmpty {
                    placeLazy()
                        .padding(.top, 5)
                } else {
                    if !viewModel.searchLoad {
                        emptyView
                            .padding(.top, 114)
                    }
                }
            }
        }
        .background(Color.white)
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
        .onChange(of: viewModel.searchKeyword) { newValue, _ in
            if newValue.isEmpty {
                viewModel.showResult = false
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.searchKeyword)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Subviews
    
    private var topTitle: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("어떤 장소를 \n찾고 계신가요?")
                    .font(.Headline2)
                    .foregroundStyle(Color.g7)
                    .lineSpacing(4.5)
                
                Text("Catch:y에서 알려드릴게요!")
                    .font(.body2)
                    .foregroundStyle(Color.g4)
            }
            Spacer()
        }
    }
    
    private var recentKeywords: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("최근 검색어")
                .font(.body2)
                .foregroundStyle(Color.g5)
            FlowLayout(tags: viewModel.recentWords) { keyword in
                makeButton(keyword)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
    }
    
    private func placeLazy() -> some View {
        let gridItems = [GridItem(.flexible())]
        let data = viewModel.flatSearchData
        let count = data.count
        
        return ScrollView(.vertical) {
            LazyVGrid(columns: gridItems, spacing: 30) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    VStack(spacing: 19) {
                        SearchRecommendPlaceCard(data: item)
                            .onAppear {
                                if index == count - 1 {
                                    viewModel.performSearch(for: viewModel.searchKeyword)
                                }
                            }
                        
                        if index < count - 1 {
                            Divider()
                                .foregroundStyle(Color.g2)
                                .frame(height: 1)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .refreshable {
            await viewModel.searchRefresh()
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .main
        }
    }
    
    private var emptyView: some View {
        VStack(alignment: .center, spacing: 0) {
            Icon.emptyResult.image
                .fixedSize()
            
            Text("검색어와 일치하는 내용이 없어요!")
                .font(.Subtitle2)
                .foregroundStyle(Color.g7)
                .padding(.top, 15)
            
            Text("확인 후 다시 검색해주세요.")
                .font(.Body1_2)
                .foregroundStyle(Color.g4)
            
            Spacer()
        }
    }
}

extension SearchView {
    func makeButton(_ text: String) -> some View {
        Button(action: {
            viewModel.searchKeyword = text
        }) {
            Text(text)
                .font(.caption1)
                .foregroundStyle(Color.g4)
                .lineLimit(1)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.clear)
                        .stroke(Color.g3, lineWidth: 1)
                )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(container: DIContainer())
    }
}
