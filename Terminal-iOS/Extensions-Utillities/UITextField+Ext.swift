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
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            calculatedFont = UIFont.notosansMedium(size: size)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            calculatedFont = UIFont.notosansMedium(size: size * 1.05)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
        case 812.0: //iphone X, XS => 5.8 inch
            calculatedFont = UIFont.notosansMedium(size: size * 1.15)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            calculatedFont = UIFont.notosansMedium(size: size * 1.20)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
        case 926.0:
            calculatedFont = UIFont.notosansMedium(size: size * 1.25)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
        default:
            print("not an iPhone")
        }
    }
    
    private func resizeFont(calculatedFont: UIFont?, weight: UIFont.Weight) {
        self.font = calculatedFont
        self.font = UIFont.systemFont(ofSize: calculatedFont!.pointSize, weight: weight)
    }
}
