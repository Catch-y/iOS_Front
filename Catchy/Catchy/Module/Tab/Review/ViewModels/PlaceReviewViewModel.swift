//
//  PlaceReviewViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 12/24/25.
//

import Foundation
import Combine

@Observable
class PlaceReviewViewModel {
    var place: PlaceAllReviewResponse?
    
    let container: DIContainer
    let cancellables: Set<AnyCancellable> = .init()
    
    init(container: DIContainer) {
        self.container = container
    }
}
