//
//  GuideStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/17/25.
//

import Foundation
import SwiftUI

protocol GuideStrategy {
    var sections: [GuideSection] { get }
    var buttonType: MainBtnType { get }
}

struct GuideSection: Identifiable {
    var id: UUID = .init()
    let title: String
    let description: String
}
