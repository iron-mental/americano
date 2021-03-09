//
//  UIView+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2021/03/05.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIView {
    func warningEffect() {
        self.becomeFirstResponder()
        self.layer.borderWidth = 0.4
        self.layer.borderColor = UIColor.systemRed.cgColor
    }
}
