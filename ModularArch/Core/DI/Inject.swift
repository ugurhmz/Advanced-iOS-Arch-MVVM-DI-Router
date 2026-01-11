//
//  Inject.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    private var service: T?
    private var creator: (() -> T)?
    
    init() {}
    
    init(creator: @escaping () -> T) {
        self.creator = creator
    }
    
    var wrappedValue: T {
        mutating get {
            if service == nil {
                if let creator = creator {
                    service = ServiceLocator.shared.resolveOrCreate(T.self, creator: creator)
                } else {
                    service = ServiceLocator.shared.resolve(T.self)
                }
            }
            
            guard let foundService = service else {
                fatalError("[Inject] Service not registered: \(T.self). Lütfen AppDelegate veya SceneDelegate içinde register edin.")
            }
            
            return foundService
        }
        set {
            service = newValue
        }
    }
}
