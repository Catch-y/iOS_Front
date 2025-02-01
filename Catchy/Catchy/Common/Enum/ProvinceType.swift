//
//  ProvinceType.swift
//  Catchy
//
//  Created by 정의찬 on 2/1/25.
//

import Foundation
import SwiftUICore

enum ProvinceType: String, CaseIterable {
    case busan = "부산광역시"
    case chungcheongbuk = "충청북도"
    case chungcheongnam = "충청남도"
    case daegu = "대구광역시"
    case daejeon = "대전광역시"
    case gangwon = "강원특별자치도"
    case gwangju = "광주광역시"
    case gyeonggi = "경기도"
    case gyeongsangbuk = "경상북도"
    case gyeongsangnam = "경상남도"
    case incheon = "인천광역시"
    case jeju = "제주특별자치도"
    case jellanam = "전라남도"
    case jeollabuk = "전북특별자치도"
    case sejong = "세종특별자치시"
    case seoul = "서울특별시"
    case ulsan = "울산광역시"
    
    static func returnFillColor(for province: ProvinceType) -> Color {
        switch province {
        case .busan:
            return .busan
        case .chungcheongbuk:
            return .chungcheongbuk
        case .chungcheongnam:
            return .chungcheongnam
        case .daegu:
            return .daegu
        case .daejeon:
            return .daejeon
        case .gangwon:
            return .gangwon
        case .gwangju:
            return .gwangju
        case .gyeonggi:
            return .gyeonggi
        case .gyeongsangbuk:
            return .gyeongsangbuk
        case .gyeongsangnam:
            return .gyeongsangnam
        case .incheon:
            return .incheon
        case .jeju:
            return .jeju
        case .jellanam:
            return .jellanam
        case .jeollabuk:
            return .jeollabuk
        case .sejong:
            return .sejong
        case .seoul:
            return .seoul
        case .ulsan:
            return .ulsan
        }
    }
}
