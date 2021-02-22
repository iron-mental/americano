//
//  UILabel+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension UILabel {
    func dynamicFont(fontSize size: CGFloat) {
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
            self.font = .notosansMedium(size: size * 1.2)
        case 926.0:
            self.font = .notosansMedium(size: size * 1.25)
        default:
            print("not an iPhone")
        }
    }
    
    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func setMargins(margin: CGFloat = 20) {
            if let textString = self.text {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.firstLineHeadIndent = margin
                paragraphStyle.headIndent = margin
                paragraphStyle.tailIndent = -margin
                let attributedString = NSMutableAttributedString(string: textString)
                attributedString.addAttribute(.paragraphStyle,
                                              value: paragraphStyle,
                                              range: NSRange(location: 0, length: attributedString.length))
                attributedText = attributedString
            }
        }
}
