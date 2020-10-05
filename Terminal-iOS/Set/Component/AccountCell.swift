//
//  AccountCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class AccountCell: DefaultCell {
    static let accountCellId = "accountCell"
    
    lazy var rightImage = UIImageView()
    
    override func attribute() {
        super.attribute()
        rightLabel.isHidden = true
        
//        rightImage.do {
//            $0.image = #imageLiteral(resourceName: "accept")
//        }
    }

    override func layout() {
        super.layout()
//        addSubview(rightImage)
//        rightImage.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
//            $0.widthAnchor.constraint(equalToConstant: 35).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        }
    }
}
