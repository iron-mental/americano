//
//  EmailModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/10.
//  Copyright © 2020 정재인. All rights reserved.
//
import UIKit

class EmailModifyView: UIView {
    
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        emailLabel.do {
            $0.text = "Email"
            $0.textColor = .white
        }
        emailTextField.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.addLeftPadding()
            $0.isEnabled = false
        }
    }
    func layout() {
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        
        emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        }
        emailTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
