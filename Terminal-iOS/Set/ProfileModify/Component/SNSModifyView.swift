//
//  SNSModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/10.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSModifyView: UIView {
    lazy var snsLabel = UILabel()
    lazy var gitImage = UIImageView()
    lazy var gitLabel = UILabel()
    lazy var gitTextField = UITextField()
    lazy var linkedImage = UIImageView()
    lazy var linkedLabel = UILabel()
    lazy var linkedTextField = UITextField()
    lazy var webImage = UIImageView()
    lazy var webLabel = UILabel()
    lazy var webTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
  
    func attribute() {
        snsLabel.do {
            $0.text = "SNS"
        }
        gitImage.do {
            $0.image = #imageLiteral(resourceName: "github")
            $0.backgroundColor = .white
        }
        gitLabel.do {
            $0.text = "Github"
            $0.textAlignment = .left
        }
        gitTextField.do {
            $0.placeholder = "Github ID"
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
        linkedImage.do {
            $0.image = #imageLiteral(resourceName: "linkedin")
        }
        linkedLabel.do {
            $0.text = "LinkedIn"
            $0.textAlignment = .left
        }
        linkedTextField.do {
            $0.placeholder = "LinkedIn URL"
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
        webImage.do {
            $0.image = #imageLiteral(resourceName: "web")
        }
        webLabel.do {
            $0.text = "Web"
            $0.textAlignment = .left
        }
        webTextField.do {
            $0.placeholder = "URL"
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
    }
    
    func layout() {
        [snsLabel, gitImage, gitLabel, gitTextField, linkedImage, linkedLabel, linkedTextField, webImage, webLabel, webTextField]
            .forEach { self.addSubview($0) }
        
        snsLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        }
        gitImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        gitLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: gitImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: gitImage.trailingAnchor, constant: 10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 70).isActive = true
        }
        gitTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: gitImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: gitLabel.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 28)).isActive = true
        }
        linkedImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: gitImage.bottomAnchor, constant: 17).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        linkedLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: linkedImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: linkedImage.trailingAnchor, constant: 10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 70).isActive = true
        }
        linkedTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: linkedImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: linkedLabel.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 28)).isActive = true
        }
        webImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: linkedImage.bottomAnchor, constant: 17).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }
        webLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: webImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: webImage.trailingAnchor, constant: 10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 70).isActive = true
        }
        webTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: webImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: webLabel.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 28)).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
