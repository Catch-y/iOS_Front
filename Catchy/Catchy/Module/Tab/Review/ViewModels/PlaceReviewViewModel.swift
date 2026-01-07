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
    var isLoading: Bool = true
    
    let container: DIContainer
    let cancellables: Set<AnyCancellable> = .init()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    public func reviewTotalInfo() -> ReviewTotalInfo? {
        guard let place else {
            return .init(totalCount: 0, averageRating: 0, ratingInfo: (1...5).reversed().map { .init(score: $0, count: 0) })
        }
        return ReviewTotalInfo(
            totalCount: place.totalCount,
            averageRating: place.averageRating,
            ratingInfo: place.ratingList
        )
    }
}
