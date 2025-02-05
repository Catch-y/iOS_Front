//
//  SearchView.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    @State private var showResults = false
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack(alignment: .center, content: {
            
            CustomNavigation(action: {
                viewModel.container.navigationRouter.pop()
            }, title: nil, rightNaviIcon: nil)
            .padding(.horizontal, 16)
            
            if viewModel.searchKeyword.isEmpty {
            Spacer().frame(height: 95)
                topTitle
                    .padding(.leading, 25)
                    .transition(.opacity)
            }
            
            CustomTextField(text: $viewModel.searchKeyword, onSubmit: {
                viewModel.saveKeyword(viewModel.searchKeyword)
            } , searchTextField: .searchView)
                .padding(.top, 20)
                .padding(.horizontal, 16)
                .animation(.easeInOut(duration: 0.5), value: viewModel.searchKeyword)
                .submitScope()
            
            if !viewModel.recentWords.isEmpty && viewModel.searchKeyword.isEmpty {
                recenteKeywords
                    .padding(.top, 38)
                    .padding(.horizontal, 25)
            }
            if showResults {
                if !viewModel.searchKeyword.isEmpty {
                    if let placeResult = viewModel.searchResult {
                        placeLazy(placeResult: placeResult)
                            .padding(.horizontal, 16)
                            .padding(.top, 32)
                    } else {
                        if !viewModel.searchLoad {
                            emptyView
                                .padding(.top, 114)
                        }
                    }
                }
            }
            Spacer()
        })
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
        .onChange(of: viewModel.searchKeyword) { newValue, oldValue in
            showResults = false
            if !newValue.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    showResults = true
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.searchKeyword)
    }
    
    
    private var topTitle: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8, content: {
                Text("어떤 장소를 \n찾고 계신가요?")
                    .font(.Headline2)
                    .foregroundStyle(Color.g7)
                    .lineSpacing(4.5)
                
                Text("Catch:y에서 알려드릴게요!")
                    .font(.body2)
                    .foregroundStyle(Color.g4)
            })
            
            Spacer()
        }
    }
    
    private var recenteKeywords: some View {
        VStack(alignment: .leading, spacing: 14, content: {
            Text("최근 검색어")
                .font(.body2)
                .foregroundStyle(Color.g5)
            FlowLayout(tags: viewModel.recentWords) { keyword in
                        makeButton(keyword)
                    }
        })
        .frame(maxWidth: .infinity, maxHeight: 120)
    }
    
    private func placeLazy(placeResult: SearchPlaceResponse) -> some View {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 30, content: {
                ForEach(Array(placeResult.content.enumerated()), id: \.element.id) { index, result in
                    VStack(spacing: 19, content: {
                        SearchRecommendPlaceCard(data: result)
                        
                        if index < placeResult.content.count - 1 {
                            Divider()
                                .foregroundStyle(Color.g2)
                                .frame(height: 1)
                        }
                    })
                }
            })

    }
    
    private var emptyView: some View {
        VStack(alignment: .center, spacing: 0, content: {
            Icon.emptyResult.image
                .fixedSize()
            
            Text("검색어와 일치하는 내용이 없어요!")
                .font(.Subtitle2)
                .foregroundStyle(Color.g7)
                .padding(.top, 15)
            
            Text("확인 후 다시 검색해주세요.")
                .font(.Body1_2)
                .foregroundStyle(Color.g4)
        })
        
    }
}

extension SearchView {
    func makeButton(_ text: String) -> some View {
        Button(action: {
            print(text)
        }, label: {
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
        })
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        SearchView(container: DIContainer())
    }
}
