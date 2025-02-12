//
//  SimilarPlacesViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import Foundation

class SimilarPlacesViewModel: ObservableObject {
    @Published var recommendPlaceResponse: [RecommendPlaceResponseData]?
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
