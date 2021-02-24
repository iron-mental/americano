//
//  SettingCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class NotiCell: DefaultCell {
    static let notiCellId = "notiCell"
    
    lazy var notiToggle = UISwitch()
    
    override func attribute() {
        super.attribute()
        rightLabel.isHidden = true
        self.accessoryView = notiToggle
        notiToggle.addTarget(self, action: #selector(notiToggleDidTap(_: )), for: .touchUpInside)
        
        if let isOn = KeychainWrapper.standard.bool(forKey: "notiToggle") {
            if isOn {
                notiToggle.setOn(true, animated: true)
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                UIApplication.shared.unregisterForRemoteNotifications()
                notiToggle.setOn(false, animated: true)
            }
        } else {
            notiToggle.setOn(false, animated: true)
        }
    }
    
    @objc func notiToggleDidTap(_ sender: UISwitch) {
        KeychainWrapper.standard.set(sender.isOn, forKey: "notiToggle")
        guard let isOn = KeychainWrapper.standard.bool(forKey: "notiToggle") else { return }
        if isOn {
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
}
