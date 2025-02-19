//
//  PlaceBucketView.swift
//  Catchy
//
//  Created by LEE on 2/6/25.
//

import SwiftUI

/// 담아둔 장소 화면
struct PlaceBucketView: View {
        
    @EnvironmentObject var container: DIContainer
    
    
    @ObservedObject var viewModel: DIYCourseViewModel
    
    // MARK: - 담아둔 장소 화면 Properties
    
//    @Binding var selectedPlaceList: [PlaceSearchResponseData]
//    
//    /// 담아둔 장소 화면 상태
//    @Binding var isBucketViewPresented: Bool
        
    init(viewModel: DIYCourseViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavigation(
                
                action: {
                    container.navigationRouter.pop()
                },
                title: "담아둔 장소",
                rightNaviIcon: nil,
                isShadow: true
            )
            if $viewModel.selectedPlaceList.isEmpty {
                infoView
                Spacer()

            } else {
                scrollView

            }
        }
        .ignoresSafeArea(edges: .top)
        .background(.bg1)
        .navigationBarBackButtonHidden(true)
        
        
    }
    
    /// 스크롤 뷰
    /// 담은 장소 카드를 보여줌
    private var scrollView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 20, content: {
                ForEach(Array(viewModel.selectedPlaceList.enumerated()), id: \.element.id) {(index, place) in
                    PlaceBucketCard(
                        placeSearchResponseData: place,
                        index: index,
                        canDelete: true
                    ) {
                        viewModel.selectedPlaceList.remove(at: index)
                    }.environmentObject(container)
                }
                
            }
            )
            .padding(.top, 38)
            .safeAreaPadding(.horizontal, 16)
            .padding(.bottom, 30)
            
            MainBtn(text: "코스 생성하기" ,
                    action: {
                container.navigationRouter.push(to: .diyCourseCreateView(placeIds: Array(viewModel.selectedPlaceList.map(\.self.placeId))))
            },
                    width: UIScreen.screenWidth - 32,
                    height: 60,
                    onoff: !$viewModel.selectedPlaceList.isEmpty ? .custom : .off
            )
            .disabled($viewModel.selectedPlaceList.isEmpty)
            
        }
    }
    
    /// 담은 장소가 없을 때 뷰
    private var infoView : some View {
        VStack(spacing: 9){
            Icon.smileSearch.image
                .fixedSize()
                .padding(.bottom, 6)
            Text("담아둔 장소가 없어요!")
                .font(.Subtitle2)
                .foregroundStyle(.g7)
            Text("마음에 드는 장소를 담아보세요.")
                .font(.Body1_2)
                .foregroundStyle(.g4)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        
    }
}


