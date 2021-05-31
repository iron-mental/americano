//
//  UITextView+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension UITextView {
    func dynamicFont(size: CGFloat, weight: FontWeight) {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        var fontSize: CGFloat?
        
        switch height {
        case 667.0: // iphone 6, 6s, 7, 8
            fontSize = size
        case 736.0: // iphone 6s+ 6+, 7+, 8+
            fontSize = size * 1.05
        case 812.0: // iphone X, XS
            fontSize = size * 1.12
        case 844.0: // iphone 12, 12pro
            fontSize = size * 1.17
        case 896.0: // iphone XR, XS MAX
            fontSize = size * 1.2
        case 926.0: // iphone 12pro max
            fontSize = size * 1.25
        default:
            fontSize = size
        }
        
        switch weight {
        case .bold:
            self.font = .notosansBold(size: fontSize!)
        case .medium:
            self.font = .notosansMedium(size: fontSize!)
        case .regular:
            self.font = .notosansRegular(size: fontSize!)
        }
    }
}
