//
//  PlaceVisitingView.swift
//  Catchy
//
//  Created by LEE on 2/10/25.
//

import SwiftUI

/// 코스 상세 정보 -> 장소 방문 뷰
struct PlaceVisitingView: View {

    @StateObject var viewModel: PlaceVisitingViewModel

    @Binding var placeId: Int

    init(container: DIContainer, placeId: Binding<Int>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self._placeId = placeId
    }

    var body: some View {

        VStack(spacing: 16) {
            if let place = viewModel.placeDetailResponse {

                PlaceInfoSection(place: place)
                buttonGroup

                
                buttonGroup
                
                MainBtn(
                    text: "길 찾기",
                    action: {
                    },
                    width: 370,
                    height: 55,
                    onoff: .on)

            } else {
                ProgressView()
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
            
            reviewBtn
            
            stamp
            Spacer()
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 30)
    }

    
    /// 방문 체크 버튼
    private var visitCheckbtn: some View {

        Button(action: {print("터치")}, label: {

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
    private var reviewBtn: some View {

        Button(action: {print("터치")},
               label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16.5)
                    .fill(.white)
                    .stroke(.main)
                    .frame(width: 108, height: 36)

                HStack(spacing: 7) {

                    Icon.colorReview.image

                    Text("리뷰 남기기")
                        .foregroundStyle(.main)
                        .font(.body3)

                }
            }
        }
        )
    }


    /// 스탬프
    private var stamp: some View {

        Button(action: { print("gd") }, label: {
            Icon.emptyStamp.image
        })
    }
}

struct PlaceVisitingView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11"],
            id: \.self
        ) { deviceName in
            PlaceVisitingView(container: DIContainer(), placeId: .constant(1))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(DIContainer())
        }
    }
}
