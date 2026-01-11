//
//  ServiceLocator.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    
    private var services: [String: Any] = [:]
    
    private init() {}
    
    func register<T>(_ service: T) {
        let key = "\(T.self)"
        services[key] = service
        print("[ServiceLocator] Registered: \(key)")
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = "\(type)"
        return services[key] as? T
    }
    
    func resolveOrCreate<T>(_ type: T.Type, creator: @escaping () -> T) -> T {
        if let service = resolve(type) {
            return service
        }
        let newService = creator()
        register(newService)
        return newService
    }
}
