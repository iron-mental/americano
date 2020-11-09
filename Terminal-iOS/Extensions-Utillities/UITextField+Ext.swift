//
//  UITextfield+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension UITextField {
    func dynamicFont(fontSize size: CGFloat, weight: UIFont.Weight) {
        let currentFontName = self.font!.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            calculatedFont = UIFont(name: currentFontName, size: size)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 1.05)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 812.0: //iphone X, XS => 5.8 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 1.15)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 1.2)
            resizeFont(calculatedFont: calculatedFont, weight: weight)
            break
        default:
            print("not an iPhone")
            break
        }
    }
    
    private func resizeFont(calculatedFont: UIFont?, weight: UIFont.Weight) {
        self.font = calculatedFont
        self.font = UIFont.systemFont(ofSize: calculatedFont!.pointSize, weight: weight)
    }
}
