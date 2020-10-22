//
//  LoginView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    var emailTextfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func attribute() {
        emailTextfield.do {
            $0.placeholder = "placehodler"
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.textColor = .gray
        }
    }
    
    func layout() {
        view.addSubview(emailTextfield)
        
        emailTextfield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * ( 285 / 375 )).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * ( 32 / 667 )).isActive = true
        }
    }
}
