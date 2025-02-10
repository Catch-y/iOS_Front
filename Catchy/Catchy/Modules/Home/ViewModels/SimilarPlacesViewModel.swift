//
//  SimilarPlacesViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import Foundation

class SimilarPlacesViewModel: ObservableObject {
    @Published var recommendPlaceResponse: [RecommendPlaceResponse]? = [.init(placeId: 0, placeImageUrl: "https://i.namu.wiki/i/Ca6uA8jti6jQfstU5FzeSH6bnn9Ms8uoWBMROytYU606IZ0GLj4d8RWEAQpV3PUP1FjsuemL2y-QlMwp-m1JiQl-ZXmKvkKDfsFNK93VrWiFP9Tv7Yz71eOmMJnBKGHfQEFIfGODpVi3lwxEll8eAw.webp", category: "영화", placeName: "삼퍼티쿠시 용산점", roadAddress: "서울시 동작구", activeTime: "월-금 16:00 - 21:00", reviewCount: 203, averageRating: 4.3, isLike: false)]
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
