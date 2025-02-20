//
//  AIPlaceListView.swift
//  Catchy
//
//  Created by LEE on 2/13/25.
//

import SwiftUI

/// AI 코스 생성 결과 화면
struct AIPlaceListView: View {
    
    // MARK: - 뷰 모델
    @StateObject var viewModel: AIPlaceListViewModel
    
    // MARK: - AI 코스 생성 결과 화면 Properties
    /// 현재 화면이 보여지는 상태
    @Binding var isAISheetPresented: Bool
    
    // MARK: - Init
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
                            ) {
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
