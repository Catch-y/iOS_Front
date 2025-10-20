//
//  ProvinceActor.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/25/25.
//

import Foundation
import Combine

@Observable
class ProvinceManager {
    // MARK: - Property
    var provinceLoading: Bool = false
    /// 시, 도 저장 데이터
    var provinces: [Province] = .init()
    /// 시, 구, 읍 등 저장 데이터
    var districts: [String] = .init()
    
    // MARK: - Dependency
    let container: DIContainer
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
    /// 시/도 데이터 액세스 토큰 가져오기
    /// - Parameter code: 시/도 코드
    func provinceAccessToken(_ code: String, completion: @escaping () -> Void) {
        container.useCaseProvider.provinceUseCase.executeGetAccessToken()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Get Province AccessToken Sucess!")
                case .failure(let failure):
                    print("Get Province AccessToken Failure: \(failure)")
                }
            }, receiveValue: { [weak self] result in
                guard let self  = self else { return }
                self.getDistricts(result.result.accessToken, code, completion: completion)
            })
            .store(in: &cancellables)
    }
    
    /// 사용 액세스 토큰을 활용하여 시 내부 구 정보 받아ㅇ기
    /// - Parameters:
    ///   - token: 조회 토큰
    ///   - code: 시 코드
    private func getDistricts(_ token: String, _ code: String, completion: @escaping () -> Void) {
        container.useCaseProvider.provinceUseCase.executeGetDistricts(accessToken: token, provinceCode: code)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Get Districts Token")
                case .failure(let failure):
                    print("Get Disticts Failure: \(failure)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.districts = Array(parsingDistricts(response))
                completion()
            })
            .store(in: &cancellables)
    }
    
    /// 시 데이터 파싱
    /// - Parameter data: 시 데이터 파싱
    /// - Returns: 파싱된 데이터
    private func parsingDistricts(_ data: ProvinceResponse) -> Set<String> {
        let parsedDistricts = Set(data.result.compactMap { districts in
            let components = districts.addrName.components(separatedBy: " ")
            
            if let city = components.first(where: { $0.hasSuffix("시")}) {
                return city
            } else {
                return districts.addrName
            }
        })
        
        return parsedDistricts
    }
}
