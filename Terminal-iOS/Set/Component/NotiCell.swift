//
//  SettingCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NotiCell: DefaultCell {
    static let notiCellId = "notiCell"
    
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
