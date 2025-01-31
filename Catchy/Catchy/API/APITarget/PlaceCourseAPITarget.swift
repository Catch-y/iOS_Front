//
//  PlaceCourseAPITarget.swift
//  Catchy
//
//  Created by LEE on 1/31/25.
//

import Foundation
import Moya

enum PlaceCourseAPITarget {
    
    
}


extension PlaceCourseAPITarget: APITargetType {
    
    var path: String {
        
    }
    
    var method: Moya.Method {
        
    }
    
    var task: Task {
        
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
}
