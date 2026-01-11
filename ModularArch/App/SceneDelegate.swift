//
//  SceneDelegate.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        registerDependencies()
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let initialVC = LoginVC()
        let navigationController = UINavigationController(rootViewController: initialVC)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func registerDependencies() {
        print("[SceneDelegate] Servisler kaydediliyor...")
        let sessionService = SessionService()
        ServiceLocator.shared.register(sessionService as SessionServiceProtocol)
        ServiceLocator.shared.register(Router.shared)
        
        print("[SceneDelegate] Tüm servisler hazır!")
    }
    
}

