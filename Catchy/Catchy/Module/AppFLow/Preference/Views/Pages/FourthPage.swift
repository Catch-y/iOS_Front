//
//  FourthPage.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct FourthPage: View {
    // MARK: - Property
    @Bindable var viewModel: PreferenceViewModel
    @State var provinceManager: ProvinceManager
    
    // MARK: - Constants
    fileprivate enum FourthPageConstants {
        static let titleText: String = "마지막으로 관심 지역을 \n선택해주세요"
        static let polygonGwangju: String = "광주광역시"
        static let opacity: CGFloat = 0.5
    }
    
    // MARK: - Init
    init(viewModel: PreferenceViewModel, container: DIContainer) {
        self.viewModel = viewModel
        self.provinceManager = .init(container: container)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, content: {
            topTitle
            middleContents
        })
        .sheet(
            isPresented: .init(
                get: { viewModel.selectedRegion != nil },
                set: { new in
                    if !new {
                        viewModel.selectedRegion = nil
                    }
                }),
            content: {
                PreferenceDistrictsView(viewModel: viewModel, provoince: provinceManager)
            }
        )
        .loadingOverlay(isLoading: viewModel.isLoading, loadingTextType: .defaulLoading)
    }
    
    // MARK: - Top
    /// 상단 타이틀
    private var topTitle: some View {
        Text(FourthPageConstants.titleText)
            .font(.Subtitle1)
            .foregroundStyle(Color.g7)
            .lineSpacing(DefaultConstants.lineSpacing)
    }
    
    // MARK: - Middle
    /// 한반도 지도 컨텐츠
    private var middleContents: some View {
        GeometryReader(content: { geo in
            ZStack {
                polygonMap(geo: geo)
                polygonName(geo: geo)
            }
            .gesture(
                // TODO: - 터치 애니메이션 넣기
                DragGesture(minimumDistance: .zero)
            )
        })
        .task {
            viewModel.loadGeoJSON()
        }
    }
    
    private func mapGestureAction(at location: CGPoint, in rect: CGRect) {
        let latLong = viewModel.convertToLatLon(from: location, in: rect)
        viewModel.tappedLocatoin = .init(latitude: latLong.latitude, longitude: latLong.longitude)
        
        guard let regionInfo = viewModel.getRegionInfo(at: location, in: rect) else { return }
        viewModel.selectedRegion = regionInfo.name
        viewModel.selectedRegionCode = regionInfo.code
        
        provinceManager.provinceAccessToken(regionInfo.code)
        viewModel.regionDistricts[regionInfo.name] = provinceManager.districts
    }
    
    private func polygonMap(geo: GeometryProxy) -> some View {
        ForEach(viewModel.polygons, id: \.id) { polygon in
            if let _ = ProvinceType(rawValue: polygon.regionName) {
                PolygonShape(
                    points: polygon.points,
                    scale: polygon.scale * viewModel.viewScaleFactor,
                    offset: polygon.offset
                )
                .fill(polygonColor(provinceName: polygon.regionName))
                .frame(width: geo.size.width, height: geo.size.height)
                .zIndex(polygon.regionName == FourthPageConstants.polygonGwangju ? 2 : 1)
            }
        }
    }
    
    @ViewBuilder
    private func polygonName(geo: GeometryProxy) -> some View {
        let regionGroups = Dictionary(grouping: viewModel.polygons, by: { $0.regionName })
        ForEach(regionGroups.keys.sorted(), id: \.self) { regionName in
            if let polygon = regionGroups[regionName]?.first {
                drawRegionName(polygon, geometry: geo)
            }
        }
    }
    
    /// 땅 영역 색깔
    /// - Parameter provinceName: 땅 영역 시/도
    /// - Returns: 색 반환
    private func polygonColor(provinceName: String) -> Color {
        if let province = ProvinceType(rawValue: provinceName) {
            return ProvinceType.returnFillColor(for: province)
        } else {
            return Color.gray.opacity(FourthPageConstants.opacity)
        }
    }
    
    private func drawRegionName(_ polygon: PolygonData, geometry: GeometryProxy) -> some View {
        let transformedCenter = CGPoint(
            x: (polygon.center.x - polygon.offset.x) * polygon.scale * viewModel.viewScaleFactor + geometry.size.width / 2,
            y: (polygon.center.y - polygon.offset.y) * polygon.scale * viewModel.viewScaleFactor + geometry.size.height / 2
        )
        
        return Text(polygon.regionName)
            .font(.caption_SM)
            .foregroundStyle(Color.g7)
            .offset(y: adjustTextOffset(for: polygon.regionName))
            .position(x: transformedCenter.x, y: transformedCenter.y)
            .alignmentGuide(.leading) { _ in transformedCenter.x }
            .alignmentGuide(.top) { _ in transformedCenter.y }
            .zIndex(3)
    }
    
    private func adjustTextOffset(for regionName: String) -> CGFloat {
        switch regionName {
        case "충청남도":
            return 10
        case "경기도":
            return 15
        case "인천광역시":
            return 4
        default:
            return 0
        }
    }
}

#Preview {
    FourthPage(viewModel: .init(container: DIContainer(), appFlow: AppFlow()), container: DIContainer())
}
