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
    var result = false
    
    override func attribute() {
        super.attribute()
        accessoryView = notiToggle
        rightLabel.do {
            $0.isHidden = true
        }
        notiToggle.do { toggle in
            toggle.addTarget(self, action: #selector(notiToggleDidTap(_: )), for: .touchUpInside)
            getNotificationSetting { result in
                DispatchQueue.main.async {
                    toggle.setOn(result, animated: true)
                }
            }
        }
    }
    
    func getNotificationSetting(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { [self] in
            self.result = $0.notificationCenterSetting.rawValue == 2
            completion(result)
        }
    }
    
    @objc func notiToggleDidTap(_ sender: UISwitch) {
        if let bundleIdentifier = Bundle.main.bundleIdentifier,
           let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
}
