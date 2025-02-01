//
//  GetProvinceViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation
import Combine

class GetProvinceViewModel: ObservableObject {
    private let provinceService = ProvinceService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var provinces: [Province] = []
    @Published var districts: [DistrictResponse] = []
    
    func fetchProvinces() {
        guard let token = TokenManager.shared.accessToken, !token.isEmpty else {
            print("❌ 유효한 토큰 없어요!! 다시 발급 합니다~")
            resetToken()
            fetchProvinces()
            return
        }

        print("🛠️ Sending request with token: \(token)")

        provinceService.requestWithToken(.getProvinces(accessToken: token),
                                         responseType: ProvinceResponse.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("❌ Error fetching provinces: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.provinces = response.result
                    print("✅ Provinces fetched successfully: \(response.result)")
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchDistricts(of code: String) {
        guard let token = TokenManager.shared.accessToken, !token.isEmpty else {
            print("❌ 유효한 토큰 없어요!! 다시 발급 합니다~")
            resetToken()
            fetchDistricts(of: code)
            return
        }
        
        print("🛠️ Sending request with token: \(token)")
        
        provinceService.requestWithToken(.getDistricts(accessToken: TokenManager.shared.accessToken ?? "", provinceCode: code), responseType: [DistrictResponse].self)
            .sink(receiveCompletion: { completion in
                if case .failure(let failure) = completion {
                    print("Error get Districts: \(failure)")
                }
                
            }, receiveValue: { [weak self] districts in
                self?.districts = districts
            })
            .store(in: &cancellables)
    }
    
    func resetToken() {
        provinceService.fetchAccessToken().sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                print("🚨 Error fetching new access token: \(error)")
            }
        }, receiveValue: { newToken in
            TokenManager.shared.saveToken(newToken.result.accessToken, timeout: 4 * 60 * 60)
        }).store(in: &cancellables)
    }
}
