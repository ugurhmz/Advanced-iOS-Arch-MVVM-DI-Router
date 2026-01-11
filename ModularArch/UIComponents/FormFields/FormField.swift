//
//  FormField.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation
import UIKit

enum ValidationResult {
    case success
    case failure(String)
    
    var isValid: Bool {
        if case .success = self{
            return true
        }
        return false
    }
}

protocol ValidationProvider {
    func validate(_ text: String?) -> ValidationResult
}

struct EmailValidator: ValidationProvider {
    func validate(_ text: String?) -> ValidationResult {
        guard let text = text,
              !text.isEmpty else { return .failure("Eposta bos birakilamaz")}
        guard text.contains("@") && text.contains(".") else { return .failure("Lutfen Gecerli bir e-posta giriniz.")}
        
        return .success
    }
}
