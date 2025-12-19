//
//  CourseSheetView.swift
//  Catchy
//
//  Created by euijjang97 on 12/18/25.
//

import SwiftUI

struct CourseSheetView: View, Equatable {
    typealias Place = PlaceCourseDetailResponse
    
    // MARK: - Property
    @Bindable var viewModel: CourseRouteMapViewModel
    @State var isBouncing: Bool = false
    
    // MARK: - Constant
    fileprivate enum SheetConstants {
        static let imageHeight: CGFloat = 144
        static let placeTitleHSpacig: CGFloat = 10
        static let placeHeaderVspacing: CGFloat = 13
        static let placePointHspacing: CGFloat = 12
        static let placeFooterVspacing: CGFloat = 15
        static let placeOperatingVspacing: CGFloat = 2
        static let placeInteractionVspacing: CGFloat = 16
        static let visitCheckBtnSpacing: CGFloat = 7
        static let visitCheckPadding: EdgeInsets = .init(top: 4, leading: 7, bottom: 4, trailing: 21)
        static let visitCheckRadius: CGFloat = 20
        static let reviewBtnPadding: EdgeInsets = .init(top: 9, leading: 16, bottom: 9, trailing: 16)
        static let middleVpspacing: CGFloat = 18
        static let btnHeight: CGFloat = 50
        static let mainSpacerHeight: (CGFloat, CGFloat) = (17, 47)
        
        static let btnOverlaySize: CGSize = .init(width: 108, height: 36)
        static let placeOperationSize: CGFloat = 66
        
        static let visitText: String = "방문 체크"
        static let labelText: String = "리뷰 남기기"
    }
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.viewModel.selectedDetailPlace?.placeId == rhs.viewModel.selectedDetailPlace?.placeId
    }
    
    // MARK: - Body
    var body: some View {
        if let data = viewModel.selectedDetailPlace {
            VStack {
                topImage(data)
                Spacer().frame(height: SheetConstants.mainSpacerHeight.0)
                middleContents(data)
                Spacer().frame(height: SheetConstants.mainSpacerHeight.1)
                MainButton(btnType: .searchRoad, height: SheetConstants.btnHeight, action: {
                    guard let place = viewModel.selectedDetailPlace else { return }
                    Task {
                        await viewModel.startNavigation(to: place)
                        viewModel.selectedDetent = .height(20)
                    }
                })
                Spacer()
            }
            .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
            .safeAreaPadding(.top, DefaultConstants.defaultContentTopMargins)
        }
    }
    
    // MARK: - TopPlaceInfoContent
    /// 상단 장소 이미지
    /// - Parameter data: 장소 상세 데이터
    /// - Returns: 상단 장소 이미지 반환
    @ViewBuilder
    private func topImage(_ data: Place) -> some View {
        let imageSize: CGSize = .init(width: getScreenSize().width, height: SheetConstants.imageHeight)
        let ratio: CGFloat = 356/144
        
        if let url = data.imageUrl {
            RemoteImage(urlString: url, size: imageSize, ratio: ratio)
        } else {
            NoPoIImage(size: imageSize, ratio: ratio)
        }
    }
    
    // MARK: - MiddleContents
    private func middleContents(_ data: Place) -> some View {
        VStack(alignment: .leading, spacing: SheetConstants.middleVpspacing, content: {
            middlePlaceInfoHeader(data)
            
            Divider()
                .foregroundStyle(.g2)
            
            middlePlaceInfoFooter(data)
        })
        
    }
    
    // MARK: - MiddlePlaceHeader
    /// 중간 장소 이름, 설명 및 포인트
    /// - Parameter data: 장소 데이터
    /// - Returns: 중간 장소 설명 및 포인트 뷰 반화
    private func middlePlaceInfoHeader(_ data: Place) -> some View {
        VStack(alignment: .leading, spacing: SheetConstants.placeHeaderVspacing, content: {
            middlePlaceTitleHeader(data)
            middlePlaceTitleFooter(data)
        })
    }
    
    /// 중간 장소 이름, 카테고리, 좋아요 헤더
    /// - Parameter data: 장소 데이터
    /// - Returns: 장소 헤더 반환
    @ViewBuilder
    private func middlePlaceTitleHeader(_ data: Place) -> some View {
        HStack {
            middlePlaceTitle(data)
            Spacer()

            if let binding = Binding($viewModel.selectedDetailPlace) {
                LikeButton(data: binding, action: {
                    print("like")
                }, style: .plain())
            }
        }
    }
    
    /// 중간 장소 설명, 평점, 리뷰 푸터
    /// - Parameter data: 장소 데이터
    /// - Returns: 장소 푸터 반환
    private func middlePlaceTitleFooter(_ data: Place) -> some View {
        VStack(alignment: .leading, spacing: SheetConstants.placeHeaderVspacing, content: {
            Text(data.placeDescription ?? "장소에 대한 설명이 없습니다.")
                .font(.body3)
                .foregroundStyle(.g4)
            
            HStack(spacing: SheetConstants.placePointHspacing, content: {
                RatingPoint(point: "\(data.rating)")
                ReviewPoint(point: "\(data.reviewCount)", id: data.placeId)
            })
        })
    }
    
    
    /// 중간 장소 이름, 카테고리
    /// - Parameter data: 장소 데이터
    /// - Returns: 장소 헤더 반환
    private func middlePlaceTitle(_ data: Place) -> some View {
        HStack(spacing: SheetConstants.placeTitleHSpacig, content: {
            Text(data.placeName)
                .font(.subtitle3_SM)
                .foregroundStyle(.black)
            
            if let category = data.categoryName {
                PlaceCategoryTag(category: category.rawValue, fontColor: .white, color: category.categoryBgColor)
            }
        })
    }
    
    // MARK: - MiddlePlaceFooter
    /// 중간 장소 지역, 운영 시간, 방문 체크 리뷰
    /// - Parameter data: 장소 데이터
    /// - Returns: 장소 뷰 반환
    private func middlePlaceInfoFooter(_ data: Place) -> some View {
        VStack(alignment: .leading, spacing: SheetConstants.placeFooterVspacing, content: {
            middlePlaceOperatingInfo(data)
            middlePlaceInteraction(data)
        })
    }
    
    /// 중간 장소 지역 주소 운영 시간
    /// - Parameter data: 장소 데이터
    /// - Returns: 장소 데이터 뷰
    private func middlePlaceOperatingInfo(_ data: Place) -> some View {
        VStack(alignment: .leading, spacing: SheetConstants.placeOperatingVspacing, content: {
            RoadAddress(text: data.roadAddress)
            OperatingTime(text: data.activeTime ?? "운영 시간이 등록되어 있지 않습니다.")
            siteLink(data)
        })
        .frame(height: SheetConstants.placeOperationSize)
    }
    
    private func siteLink(_ data: Place) -> some View {
        PlaceLabel(image: Image(.domain), text: data.placeSite ?? "연결 링크가 등록되어 있지 않습니다.", labelSpacing: 1)
            .underline()
            .onTapGesture {
                if let link = data.placeSite, let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            }
    }
    
    // MARK: - Middle Interaction
    /// 중간 방문 체크 및 리뷰 작성 버튼
    /// - Parameter data: 장소 데이터
    /// - Returns: 버튼 그룹 반환
    private func middlePlaceInteraction(_ data: Place) -> some View {
        HStack(spacing: SheetConstants.placeInteractionVspacing, content: {
            visitCheckBtn(data)
            reviewBtn(data)
            stmap(data)
        })
    }
    
    /// 방문 체크 버튼
    /// - Parameter data: 장소 데이터
    /// - Returns: 장소 방문 하기 버튼
    private func visitCheckBtn(_ data: Place) -> some View {
        Button(action: {
            isBouncing = false
            Task {
                await viewModel.postPlaceVisiting()
            }
        }, label: {
            generateButton(condition: visitConditionCheck, image: (.visitCheck , .emptyVisitCheck), text: SheetConstants.visitText, padding: SheetConstants.visitCheckPadding)
                .onChange(of: visitConditionCheck, { _, new in
                    if new {
                        startBouncing()
                    } else {
                        isBouncing = false
                    }
                })
                .offset(y: visitConditionCheck && isBouncing ? -1.5 : 1.5)
                .animation(visitConditionCheck ? .easeInOut(duration: 0.8).repeatForever(autoreverses: true) : .default, value: isBouncing)
        })
        .disabled(!viewModel.isUserInsideGeofence)
    }
    
    private func reviewBtn(_ data: Place) -> some View {
        Button(action: {
            if data.visited {
                // TODO: - 네비게이션
            }
        }, label: {
            generateButton(condition: data.visited, image: (.colorReview, .review), text: SheetConstants.labelText, padding: SheetConstants.reviewBtnPadding, isVisit: false)
        })
    }
    
    private func stmap(_ data: Place) -> some  View {
        Image(data.visited ? .visitStamp : .emptyStamp)
    }
    
    private var visitConditionCheck: Bool {
        return viewModel.canVisitCheck
    }
    
    private func startBouncing() {
        isBouncing = true
    }
    
    private func generateButton(condition: Bool, image: (ImageResource, ImageResource), text: String, padding: EdgeInsets, isVisit: Bool = true) -> some View {
        HStack(spacing: SheetConstants.visitCheckBtnSpacing, content: {
            Image(condition ? image.0 : image.1)
            Text(text)
                .foregroundStyle(condition ? (isVisit ? .white : .main) : .g4)
                .font(.body3_SM)
        })
        .padding(padding)
        .background(content: {
            RoundedRectangle(cornerRadius: SheetConstants.visitCheckRadius)
                .fill(condition ? (isVisit ? .main : .clear) : .clear)
                .strokeBorder(condition ? .main : .g3, style: .init())
                .frame(width: SheetConstants.btnOverlaySize.width, height: SheetConstants.btnOverlaySize.height)
        })
    }
}

#Preview {
    @Previewable @State var sheet: Bool = false
    VStack {
        Button(action: {
            sheet.toggle()
        }, label: {
            Text("1")
        })
        .sheet(isPresented: $sheet, content: {
            CourseSheetView(viewModel: .init(places: [
                .init(placeId: 0, placeName: "1", category: .BAR, placeLatitude: 1.0, placeLongitude: 1.0, isVisited: true)
            ], container: DIContainer()))
        })
    }
}
