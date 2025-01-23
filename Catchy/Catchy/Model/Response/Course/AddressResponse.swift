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


struct LocationResponse : Codable, Hashable {
    
    let y_coor : String
    
    let full_addr : String
    
    let x_coor : String
    
    let addr_name : String
    
    let cd : String 
}
