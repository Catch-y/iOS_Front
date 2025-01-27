//
//  PlaceView.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import SwiftUI

struct PlaceView: View {
    
    
    @StateObject var viewModel: PlaceSearchViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack {
            scrollView
        }
    }
    
    /// 스크롤 뷰
    private var scrollView : some View {
        ScrollView(.vertical, content: {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 20, content: {
                if let content = viewModel.placeSearchResponse?.placeInfoPreviews {
                    ForEach(content, id: \.id) { place in
                        PlaceCard(place: place)
                            .frame(maxWidth: .infinity, minHeight: 116)
                    }
                }
            })
            
        })
    }
    
}




