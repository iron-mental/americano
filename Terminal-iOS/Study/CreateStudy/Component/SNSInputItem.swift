//
//  SNSInputItem.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/20.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSInputItem: UIView {
    let iconImageView = UIImageView()
    let textField = UITextField()
    var validImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    func attribute() {
        iconImageView.do {
            $0.image = #imageLiteral(resourceName: "notion")
            $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        textField.do {
            $0.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
            $0.text = "test"
            $0.isUserInteractionEnabled = false
        }
        validImageView.do {
            $0.image = #imageLiteral(resourceName: "Vaild")
            $0.contentMode = .scaleAspectFit
        }
    }
    func layout() {
        addSubview(iconImageView)
        addSubview(textField)
        addSubview(validImageView)
        
        iconImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: iconImageView.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
            $0.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
        validImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
