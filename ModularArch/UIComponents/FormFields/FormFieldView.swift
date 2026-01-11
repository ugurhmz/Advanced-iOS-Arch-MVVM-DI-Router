//
//  FormFieldView.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation
import UIKit
import SnapKit

class FormFieldView: UIView {
    private let textField = UITextField()
    private let errorLabel = UILabel()
    
    private var validator: ValidationProvider?
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    init(placeholder: String, validator: ValidationProvider? = nil) {
        self.validator = validator
        super.init(frame: .zero)
        setupUI(placeholder: placeholder)
        
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) { fatalError("Storyboard not supported") }
    
    @objc private func textChanged() {
        errorLabel.isHidden = true
        textField.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    @discardableResult
    func validate() -> Bool {
        guard let validator = validator else { return true }
        let result = validator.validate(textField.text)
        
        switch result {
        case .success:
            errorLabel.isHidden = true
            textField.layer.borderColor = UIColor.green.cgColor
            return true
        case .failure(let message):
            errorLabel.text = message
            errorLabel.isHidden = false
            textField.layer.borderColor = UIColor.red.cgColor
            return false
        }
    }
    
    private func setupUI(placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.autocapitalizationType = .none
        
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: 12)
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        
        addSubview(textField)
        addSubview(errorLabel)
        
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
    }
}
