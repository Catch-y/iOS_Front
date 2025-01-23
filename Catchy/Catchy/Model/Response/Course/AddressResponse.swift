//
//  AddressResponse.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation

struct AddressResponse : Codable, Hashable {
    
    let id : String
    
    let result : [LocationResponse]
    
    let errMsg : String
    
    let errCd : Int
    
    let trId : String
    
}

/*
 {
     "id": "API_0701",
     "result": [
         {
             "y_coor": "1952053",
             "full_addr": "서울특별시",
             "x_coor": "953932",
             "addr_name": "서울특별시",
             "cd": "11"
         },
         {
             "y_coor": "1695144",
             "full_addr": "부산광역시",
             "x_coor": "1144829",
             "addr_name": "부산광역시",
             "cd": "21"
         },
     ],
     "errMsg": "Success",
     "errCd": 0,
     "trId": "=LLV_API_0701_1737563704945"
 }
 */


struct LocationResponse : Codable, Hashable {
    
    let y_coor : String
    
    let full_addr : String
    
    let x_coor : String
    
    let addr_name : String
    
    let cd : String 
}

/*
 {
     "id": "API_0701",
     "result": [
         {
             "y_coor": "1944250",
             "full_addr": "서울특별시 강남구",
             "x_coor": "961366",
             "addr_name": "강남구",
             "cd": "11230"
         },
         {
             "y_coor": "1950181",
             "full_addr": "서울특별시 강동구",
             "x_coor": "968817",
             "addr_name": "강동구",
             "cd": "11250"
         },
         {
             "y_coor": "1955450",
             "full_addr": "서울특별시 중랑구",
             "x_coor": "964062",
             "addr_name": "중랑구",
             "cd": "11070"
         }
     ],
     "errMsg": "Success",
     "errCd": 0,
     "trId": "SNyP_API_0701_1737563590956"
 }
 */
