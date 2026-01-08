//
//  CourseReviewViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 1/8/26.
//

import Foundation

@Observable
class CourseReviewViewModel {
    var isLoading: Bool = false
    var course: CourseReviewAllResponse? = .init(courseRating: 223, totalCount: 22, content: [
        .init(reviewId: 0, comment: "리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ", reviewImages: [
            .init(reviewImageId: 1, imageUrl: "https://i.namu.wiki/i/DBhP7497G7ZsxBoI8ssUuYwD1-oOG6GBWGOB-T_JVVj8NxQezvXAPhi7wVg-rhrw9vQHzB0PjVFNT5l5D4xFtfpP-srmzrtxC2sPFquNmReus44NuQxQmQe14qAjuLjy2xkNQlMjDTP6IkKxdXI7xQ.webp")
        ], createdAt: "2025.01.25", creatorNickname: "다니다니"),
        .init(reviewId: 1, comment: "리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ", reviewImages: .init(), createdAt: "2025.01.25", creatorNickname: "다니다니"),
        .init(reviewId: 2, comment: "리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ", reviewImages: .init(), createdAt: "2025.01.25", creatorNickname: "다니다니"),
        .init(reviewId: 3, comment: "리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ리뷰 테스트 길게 하면 어떤 느낌일까 그냥 대충 써보아요 흐아아아아아아ㅏ", reviewImages: .init(), createdAt: "2025.01.25", creatorNickname: "다니다니")
    ], last: false)
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    public func courseReviewTotal() -> ReviewTotalInfo? {
        guard let course else {
            return .init(totalCount: 0, averageRating: 0, ratingInfo: nil)
        }
        
        return .init(totalCount: course.totalCount, averageRating: course.courseRating, ratingInfo: nil)
    }
}
