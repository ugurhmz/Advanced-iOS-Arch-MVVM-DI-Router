//
//  StorageManager.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage<T: Codable> {
    let key: String
    let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}

protocol SessionServiceProtocol {
    var isUserLoggedIn: Bool { get set }
    var userToken: String? { get set }
    func logout()
}

final class SessionService: SessionServiceProtocol {
    @UserDefaultsStorage(key: "is_logged_on", defaultValue: false)
    var isUserLoggedIn: Bool
    
    @UserDefaultsStorage(key: "auth_token", defaultValue: nil)
    var userToken: String?
    
    func logout() {
        isUserLoggedIn = false
        userToken = nil
        print("[SessionService] Kullanıcı çıkış yaptı ve veriler temizlendi.")
    }
}
