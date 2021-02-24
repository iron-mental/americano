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
        UNUserNotificationCenter.current().getNotificationSettings { (result) in
            if result.notificationCenterSetting.rawValue == 2 {
                DispatchQueue.main.async {
                    self.notiToggle.setOn(true, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.notiToggle.setOn(false, animated: true)
                }
            }
        }
    }
    
    @objc func notiToggleDidTap(_ sender: UISwitch) {
        UIApplication.openSettingsURLString
        if let bundleIdentifier = Bundle.main.bundleIdentifier,
           let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
}
