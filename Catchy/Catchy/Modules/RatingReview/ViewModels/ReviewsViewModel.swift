//
//  ReviewsViewModel.swift
//  Catchy
//
//  Created by 권용빈 on 1/22/25.
//

import Foundation

class ReviewsViewModel: ObservableObject {
    @Published var reviewResponse: ReviewResponse? = .init(
        totalRating: 2.0,
        reviewCount: [.init(score: 1, count: 20),
                      .init(score: 2, count: 999),
                      .init(score: 3, count: 1500),
                      .init(score: 4, count: 1),
                      .init(score: 5, count: 0)],
        totalCount: 2520,
        content: [.init(
            reviewId: 1,
            comment: "ssss",
            rating: 1,
            reviewImages: [.init(
                reviewImageId: 1,
                imageUrl: "https://i.namu.wiki/i/tWggtBqowGk0W5pu6Z9uZi_8qs_iAbdMC573fPCsrFuMPuPuTEiYZDyXGUsCymPqZTNv6gslp9TUsAEQ2v_it3vytlJnMG1Mhdz0bxHUZ2e5u1CJhPn7GsnNx3sLtR77Fx-6EybMT9g2MvJL4NoPlw.webp")], creatorNickname: "dragon", visitedDate: "1111")],
        last: false)
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
