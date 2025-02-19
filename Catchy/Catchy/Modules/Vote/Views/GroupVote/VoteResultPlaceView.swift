//
//  VoteResultPlaceView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

struct VoteResultPlaceView: View {
    
    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: VoteResultCategoryCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            navigationBar
            locationAndCategory
                .padding(.horizontal , 16)
            placeList
                .padding(.horizontal , 16)
                .padding(.top , 31)
        }
        .background(Color(.white))
        .padding(.bottom , 110)
    }

    // MARK: - 네비게이션 바
    private var navigationBar: some View {
        GroupNavigation(title: "투표 결과") {
            container.navigationRouter.pop() //뒤로가기
        }
    }

    // MARK: - 지역 및 추천 메시지
    private var locationAndCategory: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Icon.location.image
                    .resizable()
                    .frame(width: 12, height: 15)
                Text("서울시 용산구").font(.caption1)
            }
            .padding(.top, 31)
            
            HStack {
                Text(viewModel.category).font(.Subtitle2).foregroundStyle(.m6)
                Text("를 추천해드릴게요!").font(.Subtitle2)
            }
        }
    }

    // MARK: - 장소 리스트
    private var placeList: some View {
        ScrollView {
            VStack(spacing: 23) {
                ForEach(viewModel.places, id: \.placeId) { place in
                    VoteResultCategoryCardContentView(
                        place: place,
                        isBookmarked: viewModel.isBookmarked(place.placeId),  // 개별 북마크 상태 반영
                        onBookmarkToggle: {
                            viewModel.toggleBookmark(for: place.placeId)  // 특정 장소의 북마크 상태만 변경
                        }
                    )
                }
            }
        }
    }

}

// MARK: - Preview
struct VoteResultPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            NavigationView {
                VoteResultPlaceView(viewModel: VoteResultCategoryCardViewModel(groupId: 1, category: "카페", useSampleData: true))
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}

