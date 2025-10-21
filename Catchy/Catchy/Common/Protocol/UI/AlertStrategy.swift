//
//  AlertStrategy.swift
//  Catchy
//
//  Created by Apple Coding machine on 10/16/25.
//

import Foundation
import SwiftUI

protocol AlertStrategy {
    var title: String { get }
    var message: String? { get }
    var icon: Image? { get }
    var buttons: [MainBtnType]? { get }
    var textBinding: Binding<String>? { get }
    func primaryAction()
    func secondaryAction()
}
