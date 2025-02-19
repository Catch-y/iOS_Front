//
//  PlaceVisitingView.swift
//  Catchy
//
//  Created by LEE on 2/10/25.
//

import SwiftUI

/// 코스 상세 정보 -> 장소 방문 화면
struct PlaceVisitingView: View {

    @EnvironmentObject var container: DIContainer
    
    // MARK: - 뷰 모델
    @StateObject var viewModel: PlaceVisitingViewModel

    // MARK: - 장소 방문 화면 Properties
    /// 해당 뷰의 장소 ID
    let placeId: Int

    // MARK: - Init
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
                        viewModel.showReview()
                    })

                    buttonGroup
                    
                    MainBtn(
                        text: "길 찾기",
                        action: {
                            // TODO: - 길 찾기 구현
                        },
                        width: UIScreen.screenWidth - 32,
                        height: 55,
                        onoff: .on
                    )


                    
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
        .navigationBarBackButtonHidden()
    }

    /// 방문 체크 버튼 + 리뷰 버튼 + 방문 스탬프
    private var buttonGroup: some View {
        
        HStack(spacing: 10) {
            
            visitCheckbtn
                .disabled(viewModel.placeDetailResponse!.isVisited)
            
            reviewBtn(isVisited: viewModel.placeDetailResponse!.isVisited)
            
            stamp(isVisited: viewModel.placeDetailResponse!.isVisited)
            
            Spacer()
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 30)
    }

    // TODO: - 방문이 가능한지에 따라 처리
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
    /// - Parameter isVisited: 방문한 장소인가?
    /// - Returns: 리뷰 남기기 버튼 리턴
    private func reviewBtn(isVisited: Bool) -> some View {

        Button(action: {
            if isVisited {
                container.navigationRouter.push(to: .placeReviewRegisterView(placeId: placeId))
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
        .animation(.easeInOut(duration: 0.3), value: isVisited)

    }
    
    /// 방문 확인 스탬프
    private func stamp(isVisited: Bool) -> some View {
        

        (isVisited ? Icon.visitStamp.image : Icon.emptyStamp.image)
            .padding(.leading, 10)
            .animation(.easeInOut(duration: 0.3), value: isVisited)
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
