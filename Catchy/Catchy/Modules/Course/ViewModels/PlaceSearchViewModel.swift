//
//  PlaceSearchViewModel.swift
//  Catchy
//
//  Created by LEE on 1/27/25.
//

import Foundation
import SwiftUI
import Combine

class PlaceSearchViewModel: ObservableObject {
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Place Search View Properties
    
    /// 장소 검색 결과
    @Published var placeSearchResponse: PlaceSearchResponse?
    
    @Published var searchText: String = ""
    
    @Published var isLoading: Bool = false
    
    init(container: DIContainer){
        self.container = container
    }
    
}
