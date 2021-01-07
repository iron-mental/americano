//
//  BaseSNSModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class BaseSNSModifyView: UIView {
    lazy var firstImage = UIImageView()
    lazy var firstTextFeield = UITextField()
    
    lazy var secondImage = UIImageView()
    lazy var secondTextField = UITextField()
    
    lazy var thirdImage = UIImageView()
    lazy var thirdTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
  
    func attribute() {
        [firstImage, secondImage, thirdImage].forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = Terminal.convertWidth(value: 11)
        }
        
        [firstTextFeield, secondTextField, thirdTextField].forEach {
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
    }
    
    func layout() {
        [firstImage, firstTextFeield, secondImage, secondTextField, thirdImage, thirdTextField]
            .forEach { self.addSubview($0) }
        
        firstImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        firstTextFeield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: firstImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 28)).isActive = true
        }
        secondImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: 17).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        secondTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: secondImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: secondImage.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 28)).isActive = true
        }
        thirdImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: secondImage.bottomAnchor, constant: 17).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }
        thirdTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: thirdImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: thirdImage.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 28)).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
