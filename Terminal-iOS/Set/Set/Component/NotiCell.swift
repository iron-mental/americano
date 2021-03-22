//
//  SettingCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

final class NotiCell: DefaultCell {
    static let notiCellId = "notiCell"
    var result = false
    
    override func attribute() {
        super.attribute()
        rightLabel.do {
            $0.dynamicFont(fontSize: 15, weight: .regular)
            getNotificationSetting { result in
                DispatchQueue.main.async {
                    self.rightLabel.text = result ? "ON" : "OFF"
                    self.rightLabel.textColor = result ? UIColor.appColor(.mainColor) : .systemGray
                }
            }
        }
    }
    
    override func layout() {
        super.layout()
        self.rightLabelTrailingConstraint.isActive = false
        rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Terminal.convertWidth(value: 40)).isActive = true
    }
    
    func getNotificationSetting(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { [self] in
            self.result = $0.notificationCenterSetting.rawValue == 2
            completion(result)
        }
    }
}
