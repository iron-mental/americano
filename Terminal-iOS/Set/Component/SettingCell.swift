//
//  SettingCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SettingCell: DefaultCell {
    static let settingCellId = "settingCell"
    
    lazy var notiToggle = UISwitch()
    
    override func attribute() {
        rightLabel.isHidden = true
    }
    
    override func layout() {
        super.layout()
        addSubview(notiToggle)
        notiToggle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        }
    }
}
