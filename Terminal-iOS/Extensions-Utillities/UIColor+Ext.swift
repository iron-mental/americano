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
    case cellBackground
    case studySubTitle
    case mainColor
    case InputViewColor
    case testColor
    case profileTextColor
    case noticeColor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .terminalBackground:
            return #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1098039216, alpha: 1)
        case .cellBackground:
            return #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.137254902, alpha: 1)
        case .studySubTitle:
            return #colorLiteral(red: 0.5843137255, green: 0.5843137255, blue: 0.5843137255, alpha: 1)
        case .mainColor:
            return #colorLiteral(red: 0.1607843137, green: 0.462745098, blue: 0.9529411765, alpha: 1)
        case .InputViewColor:
            return #colorLiteral(red: 0.1139655635, green: 0.1133503988, blue: 0.1351134777, alpha: 1)
        case .testColor:
            return #colorLiteral(red: 0.09033346921, green: 0.08997825533, blue: 0.1030491814, alpha: 1)
        case .profileTextColor:
            return #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1)
        case .noticeColor:
            return #colorLiteral(red: 0.1333333333, green: 0.5294117647, blue: 0.6745098039, alpha: 1)
        }
        
    }
}
