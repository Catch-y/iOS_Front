//
//  LocationSelectViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI
import Combine
import Moya

class LocationSelectViewModel: ObservableObject {
    @Published var selectedLocation: String? // 선택된 상위 지역
    @Published var selectedSubLocation: String? // 선택된 하위 지역
    @Published var locations: [String] = [] // 서버에서 받아온 지역 목록
    @Published var sublocations: [String] = [] // 서버에서 받아온 하위 지역 목록
    @Published var selectedProvinceCode: String? // 선택된 지역 코드

    private let getProvinceViewModel = GetProvinceViewModel()
    private let container: DIContainer

    private var cancellables = Set<AnyCancellable>()

    // 초기화
    init(container: DIContainer) {
        self.container = container
        fetchLocations() // 최초 실행 시 지역 목록 가져오기
    }

    // MARK: -  상위 지역(시/도) 목록 가져오기
    func fetchLocations() {
        getProvinceViewModel.fetchProvinces()
        getProvinceViewModel.$provinces
            .receive(on: DispatchQueue.main)
            .sink { [weak self] provinces in
                self?.locations = provinces.map { $0.addrName }
            }
            .store(in: &cancellables)
    }

    // MARK: - 선택된 상위 지역(시/도)에 따른 하위 지역(구/군) 목록 가져오기
    func fetchSubLocations() {
        guard let selectedLocation = selectedLocation else {
            print("🔴 선택된 상위 지역이 없습니다.")
            return
        }

        guard let selectedProvince = getProvinceViewModel.provinces.first(where: { $0.addrName == selectedLocation }) else {
            print("🔴 선택한 지역에 해당하는 코드가 없습니다.")
            return
        }

        selectedProvinceCode = selectedProvince.cd //  지역 코드 저장

        getProvinceViewModel.fetchDistricts(of: selectedProvince.cd) { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.sublocations = self?.getProvinceViewModel.districts ?? []
                }
            }
        }
    }
}
