//
//  LoginVC.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation
import SnapKit
import UIKit

final class LoginVC: BaseVC<LoginVM> {
    
    private let headerLabel: HeaderLabel = {
        let label = HeaderLabel()
        label.text = "Giris Yap"
        return label
    }()
    
    private let subHeaderLabel: BodyLabel = {
        let label = BodyLabel()
        label.text = "Modüler mimari örneğine hoş geldiniz. Lütfen devam etmek için e-posta adresinizi girin."
        label.textAlignment = .center
        return label
    }()
    
    private let emailField = FormFieldView(placeholder: "E-posta adresi",
                                           validator: EmailValidator())
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giris Yap", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLoginTap), for: .touchUpInside)
        return button
    }()
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(headerLabel)
        view.addSubview(subHeaderLabel)
        view.addSubview(emailField)
        view.addSubview(loginButton)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.centerX.equalToSuperview()
        }
        
        subHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(subHeaderLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(70)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onLoginSuccess = { [weak self] in
            let alert = UIAlertController(title: "Basarili", message: "Giris Yapildi :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    @objc func handleLoginTap() {
        guard emailField.validate() else { return }
        
        guard let email = emailField.text else { return }
        viewModel.login(email: email)
    }
}
