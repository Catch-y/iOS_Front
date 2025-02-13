//
//  AIPlaceListView.swift
//  Catchy
//
//  Created by LEE on 2/13/25.
//

import SwiftUI

/// AI 코스 생성 결과화면
struct AIPlaceListView: View {
    
    @StateObject var viewModel: AIPlaceListViewModel
        
    @Binding var isAISheetPresented: Bool
    
    init(courseAIResponse: CourseAICreateResponse?, container: DIContainer, isAISheetPresented: Binding<Bool> ) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, courseAIResponse: courseAIResponse))
        self._isAISheetPresented = isAISheetPresented
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 32) {
            
            CustomNavigation(action: {
                isAISheetPresented.toggle()
            }, title: nil, leftNaviIcon: nil, isShadow: true)
                
            infoText
            
            courseInfoGroup
            
            scrollView
            
            Spacer()
        }
        .ignoresSafeArea(.all)
        
    }
    
    /// XX 님을 위한 코스가 생성되었습니다.
    private var infoText: some View {
        
        VStack {
            Text(
                "\(DataFormatter.shared.makeStyledText(for: UserState.shared.getUserNickname(), with: .Subtitle1)) 님을 위한\n\(DataFormatter.shared.makeStyledText(for: "코스"))가 생성되었습니다!!"
            )
            .font(.Subtitle2)
            .lineSpacing(3)
            .foregroundStyle(.g7)
        }
        .padding(.horizontal, 16)
        
    }
    
    /// 코스 안내 텍스트 그룹
    private var courseInfoGroup: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Text(viewModel.courseAIResponse?.courseName ?? "")
                    .font(.Subtitle3_SM)
                    .foregroundStyle(.g7)
                    .lineLimit(1)
                
                Spacer()
                
                Button(action: {
                    viewModel.patchCourseBookmark()
                }, label: {
                    returnBookMakr(viewModel.isBookmark)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                })
            }
            
            Text(viewModel.courseAIResponse?.courseDescription ?? "")
                .foregroundStyle(.g4)
                .font(.body2)
                .lineSpacing(3)
                .lineLimit(2)
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)


    }
    
    /// AI가 생성한 장소 리스트 보여줌
    private var scrollView: some View {
        VStack(spacing: 0) {
            Divider()
                .foregroundStyle(.g2)
            
            ScrollView(.vertical) {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible()), count: 1),
                    spacing: 20,
                    content: {
                        ForEach(
                            Array(viewModel.courseAIResponse?.placeInfos.enumerated() ?? [].enumerated()),
                            id: \.element.id
                        ) {
                            index,
                            place in
                            PlaceBucketCard(
                                placeSearchResponseData: place,
                                index: index,
                                canDelete: false
                            ) { (index) in
                                print(index)
                            }
                        }
                    
                    }
                )
                .padding(.bottom, 30)
                .padding(.top, 32)
                
                
            }
            .scrollIndicators(.hidden)
        }
        .safeAreaPadding(.horizontal, 16)

        
    }
    
    /// 북마크 이미지
    func returnBookMakr(_ bookMark: Bool) -> Image {
        if bookMark {
            Icon.bookMarkTrue.image
        } else {
            Icon.bookmark.image
        }
    }
}

//struct AIPlaceListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(
//            ["iPhone 16 Pro", "iPhone 11", "iPhone 12 mini"],
//            id: \.self
//        ) { deviceName in
//            AIPlaceListView(courseAIResponse: .init(
//                courseId: 1,
//                courseName: "서울 문화 탐방 코스",
//                courseDescription: "서울의 다양한 문화 명소를 둘러볼 수 있는 코스입니다.\n서울의 다양한 문화 명소를 둘러볼 수 있는 코스입니다@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
//                recommendTime: "10:00 - 18:00",
//                courseImage: "https://example.com/images/seoul_course.jpg",
//                courseRating: 4.6,
//                placeInfos: [
//                    PlaceSearchResponseData(
//                        placeId: 101,
//                        placeName: "경복궁",
//                        placeImage: "https://example.com/images/gyeongbokgung.jpg",
//                        category: .CULTURELIFE,
//                        roadAddress: "서울특별시 종로구 사직로 161",
//                        activeTime: "09:00 - 18:00",
//                        rating: 4.8,
//                        reviewCount: 1200
//                    ),
//                    PlaceSearchResponseData(
//                        placeId: 102,
//                        placeName: "남산타워",
//                        placeImage: "https://example.com/images/namsan.jpg",
//                        category: .REST,
//                        roadAddress: "서울특별시 용산구 남산공원길 105",
//                        activeTime: "10:00 - 22:00",
//                        rating: 4.7,
//                        reviewCount: 950
//                    ),
//                    PlaceSearchResponseData(
//                        placeId: 103,
//                        placeName: "인사동 전통거리",
//                        placeImage: "https://example.com/images/insadong.jpg",
//                        category: .SPORT,
//                        roadAddress: "서울특별시 종로구 인사동길",
//                        activeTime: "10:00 - 20:00",
//                        rating: 4.5,
//                        reviewCount: 700
//                    ),
//                    PlaceSearchResponseData(
//                        placeId: 104,
//                        placeName: "한강공원",
//                        placeImage: "https://example.com/images/hanriver.jpg",
//                        category: .CAFE,
//                        roadAddress: "서울특별시 영등포구 여의도동 85",
//                        activeTime: "24시간 운영",
//                        rating: 4.6,
//                        reviewCount: 850
//                    ),
//                    PlaceSearchResponseData(
//                        placeId: 102,
//                        placeName: "남산타워",
//                        placeImage: "https://example.com/images/namsan.jpg",
//                        category: .REST,
//                        roadAddress: "서울특별시 용산구 남산공원길 105",
//                        activeTime: "10:00 - 22:00",
//                        rating: 4.7,
//                        reviewCount: 950
//                    )
//                    
//                ]
//            ), container: DIContainer()
//            )
//            
//        }
//        
//    }
//    
//    
//}
