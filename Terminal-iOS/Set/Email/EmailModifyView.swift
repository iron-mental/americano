//
//  EmailModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class EmailModifyView: UIViewController {
    var presenter: EmailModifyPresenterProtocol?
    
    var email: String?
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.view.backgroundColor = .appColor(.terminalBackground)
        self.emailLabel.do {
            $0.text = "Email"
            $0.textColor = .white
        }
        self.emailTextField.do {
            $0.text = email ?? ""
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.addLeftPadding()
        }
    }
    
    private func layout() {
        self.view.addSubview(emailLabel)
        self.view.addSubview(emailTextField)
        
        self.emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        }
        self.emailTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
}

extension EmailModifyView: EmailModifyViewProtocol {
   
}
