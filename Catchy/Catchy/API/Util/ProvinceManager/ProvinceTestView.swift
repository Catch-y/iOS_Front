//
//  TestView.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import SwiftUI

struct ProvinceTestView: View {
    
    @StateObject var viewModel: GetProvinceViewModel = .init()
    
    var body: some View {
        VStack {
            
            Button(action: {
                viewModel.fetchProvinces()
            }, label: {
                Text("get")
            })
            
            Button(action: {
                viewModel.fetchDistricts(of: viewModel.provinces[0].cd)
            }, label: {
                Text("get222")
            })
        }
    }
}

#Preview {
    ProvinceTestView()
}
