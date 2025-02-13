//
//  LocationSelectViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI

class LocationSelectViewModel: ObservableObject {
    @Published var selectedLocation: String? // 선택된 지역을 저장하는 변수

   let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }
}
