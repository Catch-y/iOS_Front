//
//  PlaceReviewReadView.swift
//  Catchy
//
//  Created by euijjang97 on 12/29/25.
//

import SwiftUI

struct PlaceReviewReadView: View {
    
    @State var viewModel: PlaceReviewViewModel
    
    init(container: DIContainer) {
        self._viewModel = .init(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack {
            if let totalInfo = viewModel.reviewTotalInfo() {
                PlaceReviewTotal(totalInfo: totalInfo)
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
        if let place = viewModel.place {
            reivewList(place: place)
        } else {
            PlaceNotReview()
            Spacer()
        }
    }
    
    private func reivewList(place: PlaceAllReviewResponse) -> some View {
        List(place.content, rowContent: { place in
            ReviewCard(
                rating: place.rating,
                images: place.reviewImages,
                comment: place.comment,
                nickname: place.creatorNickname,
                visitDate: place.visitedDate, reviewCreateDate: nil
            ) {
                print("신고하기 \(place.id)")
            }
            .equatable()
            .listRowBackground(Color.clear)
        })
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}


struct PlaceNotReview: View {
    var body: some View {
        VStack(spacing: 5, content: {
            Text("작성된 리뷰가 없습니다.")
                .font(.subtitle2)
                .foregroundStyle(.g7)
            Text("새로운 리뷰가 작성될 때까지 기다려보세요.")
                .font(.body1_2)
                .foregroundStyle(.g4)
        })
    }
}


#Preview {
    NavigationStack {
        PlaceReviewReadView(container: DIContainer())
    }
}
