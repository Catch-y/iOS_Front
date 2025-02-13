//
//  PreferenceDistrictsView.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import SwiftUI

struct PreferenceDistrictsView: View {
    
    @ObservedObject var viewModel: PreferenceViewModel
    @ObservedObject var provinceViewmodel: GetProvinceViewModel
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.g4)
                .frame(width: 32, height: 6)
            ScrollView(.vertical, content: {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), alignment: .leading, spacing: 17, content: {
                    if let selectedRegion = viewModel.selectedRegion,
                       let districts = viewModel.regionDistricts[selectedRegion]?.sorted() {
                        ForEach(districts, id: \.self) { district in
                            SelectDistrictBtn(
                                isSelectedBtn: Binding(
                                    get: { viewModel.savedDistricts.contains { $0.lowerLocation == district && $0.upperLocation == selectedRegion } },
                                    set: { newValue in
                                        if newValue {
                                            let location = StepFourStep(upperLocation: selectedRegion, lowerLocation: district)
                                            if !viewModel.savedDistricts.contains(where: { $0.lowerLocation == district && $0.upperLocation == selectedRegion }) {
                                                viewModel.savedDistricts.append(location)
                                            }
                                        } else {
                                            viewModel.savedDistricts.removeAll { $0.lowerLocation == district && $0.upperLocation == selectedRegion }
                                        }
                                    }
                                ), buttonText: district)
                        }
                    }
                })
                .padding(.top, 10)
            })
            
            MainBtn(text: "홈으로 넘어가기", action: {
                appFlowViewModel.changeTabView()
            }, width: 370, height: 60, onoff: viewModel.savedDistricts.isEmpty ? .off : .on)
            .padding(.top, 32)
            .disabled(viewModel.savedDistricts.isEmpty)
            
            Spacer()
        }
        .safeAreaPadding(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
    }
}
