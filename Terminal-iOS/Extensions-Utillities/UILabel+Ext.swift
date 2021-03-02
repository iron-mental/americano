//
//  UILabel+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension UILabel {
    func dynamicFont(fontSize size: CGFloat, weight: FontWeight) {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        var fontSize: CGFloat?
        
        switch height {
        case 667.0: //iphone 6, 6s, 7, 8
            fontSize = size
        case 736.0: //iphone 6s+ 6+, 7+, 8+
            fontSize = size * 1.05
        case 812.0: //iphone X, XS
            fontSize = size * 1.12
        case 844.0: //iphone 12, 12pro
            fontSize = size * 1.17
        case 896.0: //iphone XR, XS MAX
            fontSize = size * 1.2
        case 926.0: //iphone 12pro max
            fontSize = size * 1.25
        default:
            print("not an iPhone")
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
