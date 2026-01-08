//
//  CourseReviewReadView.swift
//  Catchy
//
//  Created by euijjang97 on 12/29/25.
//

import SwiftUI

struct CourseReviewReadView: View {
    
    @State var viewModel: CourseReviewViewModel
    
    init(container: DIContainer) {
        self._viewModel = .init(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack {
            if let totalInfo = viewModel.courseReviewTotal() {
                CourseReviewTotal(totalInfo: totalInfo)
                    .equatable()
                    .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
            }
            
            Spacer()
            
            if viewModel.isLoading {
                ProgressView()
                Spacer()
            } else {
                contentView
            }
        }
        .navigation(naviTitle: .reviewRead)
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let course = viewModel.course {
            reviewList(course: course)
        } else {
            PlaceNotReview()
            Spacer()
        }
    }
    
    private func reviewList(course: CourseReviewAllResponse) -> some View {
        List(
            course.content,
            rowContent: { course in
                ReviewCard(
                    rating: nil,
                    images: course.reviewImages,
                    comment: course.comment,
                    nickname: course.creatorNickname,
                    visitDate: nil,
                    reviewCreateDate: course.createdAt,
                    action: {
                        print("신고하기 \(course.id)")
                    }
                )
                .equatable()
                .listRowBackground(Color.clear)
        })
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    NavigationStack {
        CourseReviewReadView(container: DIContainer())
    }
}
