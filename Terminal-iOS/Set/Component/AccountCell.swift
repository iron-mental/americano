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
    }
}
