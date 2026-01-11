//
//  Router.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation
import UIKit

protocol ModelTransferable {}

protocol DataReturnable {
    func prepareInjectData(_ data: ModelTransferable?)
}

final class Router {
    static let shared = Router()
    
    private init() {}
    
    func startApp(window: UIWindow?) {
        let initVC = UIViewController()
        initVC.view.backgroundColor = .lightGray
        
        let navigationController = UINavigationController(rootViewController: initVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigate<T: UIViewController>(to type: T.Type, data: ModelTransferable? = nil) {
        let viewController = T()
        
        if let dataReceivingVC = viewController as? DataReturnable {
            dataReceivingVC.prepareInjectData(data)
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
            
            navigationController.pushViewController(viewController, animated: true)
            print("[Router] Navigating to: \(type)")
            
        } else {
            print("[Router] Navigation Controller bulunamadı!")
        }
    }
    
    func pop(animated: Bool = true) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: animated)
        }
    }
}
