//
//  UIColor+Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum AssetsColor {
    case terminalBackground
    case testColor
    case InputViewColor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .terminalBackground:
            return #colorLiteral(red: 0.2128759027, green: 0.2128818035, blue: 0.2128786147, alpha: 1)
        case .testColor:
            return #colorLiteral(red: 0.09033346921, green: 0.08997825533, blue: 0.1030491814, alpha: 1)
        case .InputViewColor:
            return #colorLiteral(red: 0.1139655635, green: 0.1133503988, blue: 0.1351134777, alpha: 1)
        }
        
    }
}
