//
//  KeychainManager.swift
//  Catchy
//
//  Created by 정의찬 on 1/11/25.
//

import Foundation
import Security

@propertyWrapper
struct KeychainStored<Value: Codable> {
    private let key: String = "catchyUser"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var wrappedValue: Value? {
        get {
            guard let data = Self.load(key: key) else { return nil }
            return try? decoder.decode(Value.self, from: data)
        }
        set {
            if let newValue = newValue,
               let data = try? encoder.encode(newValue) {
                _ = Self.save(data, for: key)
            } else {
                _ = Self.delete(key: key)
            }
        }
    }
    
    
    @discardableResult
    private static func save(_ data: Data, for key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)

        if status != errSecSuccess {
            print("키체인 저장 실패: \(status) - \(SecCopyErrorMessageString(status, nil) ?? "Unknown error" as CFString)")
        }

        return status == errSecSuccess
    }

    private static func load(key: String) -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status != errSecSuccess {
            print("키체인 로드 실패: \(status) - \(SecCopyErrorMessageString(status, nil) ?? "Unknown error" as CFString)")
        }

        return item as? Data
    }

    @discardableResult
    private static func delete(key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess && status != errSecItemNotFound {
            print("키체인 삭제 실패: \(status) - \(SecCopyErrorMessageString(status, nil) ?? "Unknown error" as CFString)")
        }

        return status == errSecSuccess || status == errSecItemNotFound
    }
}
