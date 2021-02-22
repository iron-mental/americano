//
//  UITextfield+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func dynamicFont(fontSize size: CGFloat, weight: UIFont.Weight) {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            self.font = .notosansMedium(size: size)
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            self.font = .notosansMedium(size: size * 1.05)
        case 812.0: //iphone X, XS => 5.8 inch
            self.font = .notosansMedium(size: size * 1.15)
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            self.font = .notosansMedium(size: size * 1.20)
        case 926.0:
            self.font = .notosansMedium(size: size * 1.25)
        default:
            print("not an iPhone")
        }
    }
}
