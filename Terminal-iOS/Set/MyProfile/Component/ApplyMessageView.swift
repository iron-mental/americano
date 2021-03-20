//
//  ApplyMessageView.swift
//  Terminal-iOS
//
//  Created by once on 2021/03/01.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class ApplyMessageView: UIView {
    let message = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        self.message.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .medium)
            $0.textColor = .appColor(.profileTextColor)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byCharWrapping
        }
    }
    func layout() {
        self.addSubview(message)
        
        self.message.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
