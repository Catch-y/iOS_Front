//
//  PlaceVisitingView.swift
//  Catchy
//
//  Created by LEE on 2/10/25.
//

import SwiftUI

/// 코스 상세 정보 -> 장소 방문 뷰
struct PlaceVisitingView: View {

    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: PlaceVisitingViewModel

    /// 해당 뷰의 장소 ID
    let placeId: Int

    init(container: DIContainer, placeId: Int) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self.placeId = placeId
    }

    var body: some View {

        VStack(spacing: 16) {
            if !viewModel.isLoading {
                if let place = viewModel.placeDetailResponse {
            
                    PlaceInfoSection(place: Binding(
                        get: { place },
                        set: { viewModel.placeDetailResponse = $0 }
                    ), likeTap: {
                        viewModel.patchPlaceLike()
                    }, reviewTap: {
                        // TODO: - 리뷰 보는 화면으로 이동
                    })

                    buttonGroup
                    
                    MainBtn(
                        text: "길 찾기",
                        action: {
                        },
                        width: 400,
                        height: 55,
                        onoff: .on
                    )
                    .safeAreaPadding(.horizontal, 16)
                    
                    Spacer()
                    
                }
            }
             else {
                 MainProgressComponents()
            }

        }
        .task {
            viewModel.getPlaceDetail(placeId: placeId)
        }
        .fullScreenCover(isPresented: $viewModel.isPresented) {
            PlaceReviewRegisterView(container: container, placeId: placeId, isPresented: $viewModel.isPresented)
        }
        .navigationBarBackButtonHidden()
    }

    /// 방문 체크 버튼 + 리뷰 버튼 + 방문 스탬프
    private var buttonGroup: some View {
        
        HStack(spacing: 10) {
            
            visitCheckbtn
            
            reviewBtn(isVisited: viewModel.placeDetailResponse!.isVisited)
            
            stamp(isVisited: viewModel.placeDetailResponse!.isVisited)
            
            Spacer()
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 30)
    }

    /// 방문 체크 버튼
    private var visitCheckbtn: some View {

        Button(action: {
            
            viewModel.postPlaceVisiting()
            
        }, label: {

            ZStack {
                RoundedRectangle(cornerRadius: 16.5)
                    .fill(.white)
                    .stroke(.main)
                    .frame(width: 108, height: 36)

                HStack(spacing: 7) {

                    Icon.visitCheck.image

                    Text("방문 체크")
                        .foregroundStyle(.main)
                        .font(.body3)
                        .padding(.trailing, 15)


                }
            }


        })

    }

    
    /// 리뷰 남기기 버튼
    private func reviewBtn(isVisited: Bool) -> some View {

        Button(action: {
            if isVisited {
                viewModel.show()
            }
        },
               label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16.5)
                    .fill(.white)
                    .stroke(isVisited ? .main : .g3)
                    .frame(width: 108, height: 36)

                HStack(spacing: 7) {
                    
                    isVisited ? Icon.colorReview.image : Icon.review.image

                    Text("리뷰 남기기")
                        .foregroundStyle(isVisited ? .main : .g4)
                        .font(.body3)

                }
            }
        }
        )
        
    }
    
    /// 방문 확인 스탬프
    private func stamp(isVisited: Bool) -> some View {
        isVisited ? Icon.visitStamp.image
            .padding(.leading, 10)
                : Icon.emptyStamp.image
            .padding(.leading, 10)
    }
}

struct PlaceVisitingView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11"],
            id: \.self
        ) { deviceName in
            PlaceVisitingView(container: DIContainer(), placeId: 1)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(DIContainer())
        }
    }
}
