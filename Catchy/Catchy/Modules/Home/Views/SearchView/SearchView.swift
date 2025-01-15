//
//  SearchView.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack(alignment: .center, content: {
            
            Spacer()
            
            CustomNavigation(action: {
                viewModel.container.navigationRouter.pop()
            }, title: nil, rightNaviIcon: nil)
            
            Spacer().frame(height: 95)
            
            topTitle
                .padding(.leading, 15)
            
            CustomTextField(text: $viewModel.searchKeyword, searchTextField: .searchView)
                .padding(.top, 20)
            
            if !viewModel.recentWords.isEmpty {
                recenteKeywords
                    .padding(.top, 38)
                    .padding(.horizontal, 15)
            }
            
            Spacer()
        })
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
        .frame(width: 370)
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
        .frame(width: 352, alignment: .leading)
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
