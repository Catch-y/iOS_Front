//
//  UserAvatarModel.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

// UserAvatar.swift

import Foundation
import Moya
import SwiftUI
import Combine


struct UserAvatarModel: Identifiable {
    let id = UUID()
    let imageName: String
}
