//
//  SimilarPlace.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import SwiftUI

struct SimilarPlaces: View {
    
    @StateObject var viewModel: SimilarPlacesViewModel
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack(content: {
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: nil, rightNaviIcon: nil, isShadow: true)
            
            if let _ = viewModel.recommendPlaceResponse {
                makeContents(datas: Binding(get: { viewModel.recommendPlaceResponse ?? [] },
                                            set: { viewModel.recommendPlaceResponse = $0 }))
            } else {
                ProgressView(label: {
                    Text("로딩중입니다.")
                        .font(.body3)
                        .foregroundStyle(Color.g7)
                })
                    .controlSize(.regular)
            }
            
        })
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func makeContents(datas: Binding<[RecommendPlaceResponse]>) -> some View {
        ScrollView(.vertical, content: {
            VStack(alignment: .leading, spacing: 35, content: {
                Text(DataFormatter.shared.makeStyledText(for: "\(UserState.shared.getUserNickname())님과 비슷한 취향을 \n가진 사람들이 좋아하는 장소예요"))
                    .lineLimit(2)
                    .lineSpacing(2.5)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 10, content: {
                    ForEach(datas.indices, id: \.self) { index in
                        VStack(spacing: 18, content: {
                            RecommendPlaceCard(data: datas[index])
                            
                            if index < datas.count - 1 {
                                Divider()
                                    .foregroundStyle(Color.g2)
                                    .frame(height: 1)
                            }
                        })
                    }
                })
            })
        })
        .padding(.bottom, 20)
        .padding(.horizontal, 16)
    }
}

struct SimilarPlaces_Preview: PreviewProvider {
    static var previews: some View {
        SimilarPlaces(container: DIContainer())
    }
}
