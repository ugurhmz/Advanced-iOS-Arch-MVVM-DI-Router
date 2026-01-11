//
//  BaseClasses.swift
//  ModularArch
//
//  Created by rico on 11.01.2026.
//

import Foundation
import UIKit

class BaseVM {
    required init() {}
}

class BaseVC<T: BaseVM>: UIViewController, DataReturnable {
    var viewModel: T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = T()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        print("[BaseVC] setupUI() override edilmedi: \(String(describing: self))")
    }
    
    func prepareInjectData(_ data: (any ModelTransferable)?) {
        
    }
}
