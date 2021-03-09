//
//  UIFont+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/20.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIFont {
    static func notosansBold(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansKR-Bold", size: size)!
    }
    
    static func notosansMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansKR-Medium", size: size)!
    }
    
    static func notosansRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansKR-Regular", size: size)!
    }
}
