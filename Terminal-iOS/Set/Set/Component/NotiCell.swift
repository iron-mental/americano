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
        super.attribute()
        rightLabel.isHidden = true
        notiToggle.setOn(false, animated: true)
        self.accessoryView = notiToggle
        notiToggle.addTarget(self, action: #selector(notiToggleDidTap(_: )), for: .touchUpInside)
    }
    
    @objc func notiToggleDidTap(_ sender: UISwitch) {
        print(sender)
    }
}
