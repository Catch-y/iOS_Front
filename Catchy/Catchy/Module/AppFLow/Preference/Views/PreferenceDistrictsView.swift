//
//  PreferenceDistrictsView.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/26/25.
//

import SwiftUI

/// 취향 설문 조사 지도 내부 구 선택 뷰(시트 뷰)
struct PreferenceDistrictsView: View {
    // MARK: - Property
    @Bindable var viewModel: PreferenceViewModel
    @State var provoince: ProvinceManager
    
    // MARK: - Constants
    fileprivate enum PreferenceDistricts {
        static let columnsCount: Int = 3
        static let columnSpacing: CGFloat = 17
    }
    
    // MARK: - Int
    init(viewModel: PreferenceViewModel, provoince: ProvinceManager) {
        self.viewModel = viewModel
        self.provoince = provoince
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, content: {
            middleSelectDistricts
        })
        .contentMargins(.horizontal, DefaultConstants.defaultSafeHorizon, for: .scrollContent)
        .safeAreaBar(edge: .top, spacing: DefaultConstants.defaultCapsuleSpacing, content: {
            Capsule()
                .capsuleStyle()
        })
        .safeAreaInset(edge: .bottom, content: {
            MainButton(btnType: .changeHome(onOff: viewModel.postDistrictsInfo.isEmpty ? .off : .on), action: {
                //TODO: - 버튼 액션 넣기
            })
            .padding(.bottom, DefaultConstants.defaultSafeBtnPadding)
            .disabled(viewModel.postDistrictsInfo.isEmpty)
        })
        .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
    }
    
    // MARK: - Middle
    /// 시/구 선택 버튼 그리드
    @ViewBuilder
    private var middleSelectDistricts: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: PreferenceDistricts.columnsCount)
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: PreferenceDistricts.columnSpacing, content: {
            generateMiddleBtn
        })
    }
    
    /// 시/구 선택 버튼 반복생성
    @ViewBuilder
    private var generateMiddleBtn: some View {
        if let selectedRegion = viewModel.selectedRegion,
           let districts = viewModel.regionDistricts[selectedRegion]?.sorted() {
            ForEach(districts, id: \.self) { districts in
                DistrictsBtn(
                    isSelectedBtn: districtsBinding(district: districts, region: selectedRegion),
                    buttonText: districts
                )
            }
        }
    }
    
    /// 버튼 선택 바인딩
    /// - Parameters:
    ///   - district: 선택 시/도
    ///   - region: 내부 구역(시/구)
    /// - Returns: 바인딩 Bool 반환
    private func districtsBinding(district: String, region: String) -> Binding<Bool> {
        .init(
            get: {
                viewModel.postDistrictsInfo.contains {
                    $0.lowerLocation == district &&
                    $0.upperLocation == region
                }
            },
            set: { new in
                if new {
                    let location = MemberLocationRequest(upperLocation: region, lowerLocation: district)
                    if !viewModel.postDistrictsInfo.contains(where: {
                        $0.lowerLocation == district &&
                        $0.upperLocation == region
                    }) {
                        viewModel.postDistrictsInfo.append(location)
                    }
                } else {
                    viewModel.postDistrictsInfo.removeAll(where: {
                        $0.lowerLocation == district &&
                        $0.upperLocation == region
                    })
                }
            })
    }
}
