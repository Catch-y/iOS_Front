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
    @Published var districts: [String] = []
    
    func fetchProvinces() {
        guard let token = TokenManager.shared.accessToken, !token.isEmpty else {
            print("❌ 유효한 토큰 없어요!! 다시 발급 합니다~")
            resetToken { [weak self] in
                self?.fetchProvinces()
                
            }
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
    
    func fetchDistricts(of code: String, completion: @escaping (Bool) -> Void) {
        guard let token = TokenManager.shared.accessToken, !token.isEmpty else {
            print("❌ 유효한 토큰 없어요!! 다시 발급 합니다~")
            resetToken { [weak self] in
                self?.fetchDistricts(of: code, completion: completion)
            }
            return
        }
        
        print("🛠️ Sending request with token: \(token)")
        
        provinceService.requestWithToken(.getDistricts(accessToken: token, provinceCode: code),
                                         responseType: DistrictResponse.self)
        .sink(receiveCompletion: { completionStatus in
            switch completionStatus {
            case .failure(let error):
                print("❌ Error fetching Districts: \(error.localizedDescription)")
                completion(false)
            case .finished:
                break
            }
        }, receiveValue: { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let parsedDistricts = Set(response.result.compactMap { district in
                    let components = district.addrName.components(separatedBy: " ")
                    
                    if let city = components.first(where: { $0.hasSuffix("시") }) {
                        return city
                    } else {
                        return district.addrName
                    }
                })
                self.districts = Array(parsedDistricts)
                completion(true)
            }
        })
        .store(in: &cancellables)
    }
    
    func resetToken(completion: @escaping () -> Void) {
        provinceService.fetchAccessToken().sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                print("🚨 Error fetching new access token: \(error)")
            }
        }, receiveValue: { newToken in
            TokenManager.shared.saveToken(newToken.result.accessToken, timeout: 4 * 60 * 60)
            completion()
        }).store(in: &cancellables)
    }
}
