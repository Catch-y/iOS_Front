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
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.g4)
                .frame(width: 32, height: 6)
            ScrollView(.vertical, content: {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), alignment: .leading, spacing: 17, content: {
                    ForEach(provinceViewmodel.districts, id: \.self) { district in
                        SelectDistrictBtn(
                            isSelectedBtn: Binding(
                                get: { viewModel.savedDistricts.contains { $0 == district } },
                                set: { newValue in
                                    if newValue {
                                        viewModel.savedDistricts.append(district)
                                    } else {
                                        viewModel.savedDistricts.removeAll { $0 == district}
                                    }
                                    
                                }), buttonText: district)
                    }
                })
                .padding(.top, 10)
            })
            
            MainBtn(text: "홈으로 넘어가기", action: {
                print("넘어가기")
            }, width: 370, height: 60, onoff: viewModel.savedDistricts.isEmpty ? .off : .on)
            .padding(.top, 32)
            
            Spacer()
        }
        .safeAreaPadding(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
    }
}
