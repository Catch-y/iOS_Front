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

    @State private var isBouncing = false

    // MARK: - 장소 방문 화면 Properties
    /// 해당 뷰의 장소 ID
    let placeId: Int
    let onFindRoute: (() -> Void)?
    
    

    // MARK: - Init
    init(container: DIContainer, placeId: Int, onFindRoute: (() -> Void)? = nil) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self.placeId = placeId
        self.onFindRoute = onFindRoute
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
                            onFindRoute?()
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
        .padding(.top, 32)
        .task {
            viewModel.getPlaceDetail(placeId: placeId)
        }
        .onChange(of: placeId) { oldValue, newValue in
            viewModel.getPlaceDetail(placeId: newValue)
        }
        .background(Color.white)
        .frame(height: 562, alignment: .bottom)
        .clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
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

    
    /// 방문 체크 버튼
    private var visitCheckbtn: some View {
        Button(action: {
            isBouncing = false
            viewModel.postPlaceVisiting()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16.5)
                    .fill(viewModel.isUserActuallyVisiting ? .main : .white)
                    .stroke(viewModel.isUserActuallyVisiting ? .main : .g3) // 100m 이내일 때만 활성화 색상 적용
                    .frame(width: 108, height: 36)
                    
                HStack(spacing: 7) {
                    viewModel.isUserActuallyVisiting ? Icon.visitCheck.image : Icon.emptyVisitCheck.image
                    Text("방문 체크")
                        .foregroundStyle(viewModel.isUserActuallyVisiting ? .white : .g4) // 100m 이내일 때만 활성화 색상 적용
                        .font(.body3_SM)
                }
                .padding(.trailing, 5)
            }
            .onChange(of: viewModel.isUserActuallyVisiting) { (_, newValue) in
                    if newValue {
                        startBouncing()
                    } else {
                        isBouncing = false
                    }
                }
            .offset(y: viewModel.isUserActuallyVisiting && isBouncing ? -1.5 : 1.5) // 위아래 이동
            .animation(viewModel.isUserActuallyVisiting ? .easeInOut(duration: 0.8).repeatForever(autoreverses: true) : .default, value: isBouncing)
        })
        .disabled(!viewModel.isUserNear) // 100m 이상이면 버튼 비활성화
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
    
    private func startBouncing() {
        guard viewModel.isUserActuallyVisiting else { return }
        isBouncing = true
    }

}

struct PlaceVisitingView_Previews: PreviewProvider {
    static var previews: some View {
            PlaceVisitingView(container: DIContainer(), placeId: 1)
                .environmentObject(DIContainer())
                .previewLayout(.sizeThatFits)
        }
    }
