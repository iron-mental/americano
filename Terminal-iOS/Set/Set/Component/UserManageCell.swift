//
//  UserManageCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/02.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class UserManageCell: DefaultCell {
    static let userManageCellId = "userManageCell"
    
    override func attribute() {
        super.attribute()
        rightLabel.isHidden = true
    }
}
