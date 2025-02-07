//
//  ReviewCardType.swift
//  Catchy
//
//  Created by 권용빈 on 2/7/25.
//

import Foundation

enum ReviewCardType: String, Codable {
    case myReview = "MyReview"    // “내 리뷰 보기” 화면
    case ratingReview = "RatingReview"// “평점/리뷰 전체 보기” 화면
}
