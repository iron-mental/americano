//
//  UIStackView+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/05.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
}
