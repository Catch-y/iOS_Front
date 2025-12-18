//
//  GeofenceEvent.swift
//  Catchy
//
//  Created by euijjang97 on 12/18/25.
//

import Foundation

enum GeofenceEvent: Equatable {
    case entered(String)
    case exited(String)
    case failed(String)
}
