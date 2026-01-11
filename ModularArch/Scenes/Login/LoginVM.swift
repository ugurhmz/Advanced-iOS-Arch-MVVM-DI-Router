//
//  LoginVM.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation

final class LoginVM: BaseVM {
    @Inject var sessionService: SessionServiceProtocol
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFaolure: ((String) -> Void)?
    
    func login(email: String) {
        print("[LoginVM] Giriş işlemi başlatılıyor: \(email)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.sessionService.isUserLoggedIn = true
            self.sessionService.userToken = UUID().uuidString
            
            print("[LoginVM] Oturum kaydedildi.")
            self.onLoginSuccess?()
        }
    }
}
