//
//  ApplyUserDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/18.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ApplyUserDetailView: ProfileDetailView {
    let refusalButton   = UIButton()
    let acceptButton    = UIButton()
    
    override func attribute() {
        super.attribute()
        self.refusalButton.do {
            $0.setTitle("거절", for: .normal)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.red
            $0.setTitleColor(.white, for: .normal)
        }
        self.acceptButton.do {
            $0.setTitle("수락", for: .normal)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.setTitleColor(.white, for: .normal)
        }
    }
    
    override func layout() {
        super.layout()
        [acceptButton, refusalButton].forEach { scrollView.addSubview($0) }
        self.refusalButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.location.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 115).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
        }
        self.acceptButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.location.bottomAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 115).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
        }
    }
}
