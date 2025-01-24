//
//  PreferenceViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation

class PreferenceViewModel: ObservableObject {
    
    @Published var preferenceStep: Int = 0
    
    @Published var pageCount: Int = 0
    @Published var selectedBtn: [String] = []
}
