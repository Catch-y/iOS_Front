//
//  KeychainSessionStore.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/5/25.
//

import Foundation

final class KeychainSessionStore: SessionStoring {
    @KeychainStored
    var userInfo: UserInfo?
}
