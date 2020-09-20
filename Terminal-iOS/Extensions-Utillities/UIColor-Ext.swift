//
//  UIColor-Ext.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum AssetsColor {
  case terminalBackground
}

extension UIColor {
  static func appColor(_ name: AssetsColor) -> UIColor {
    switch name {
    case .terminalBackground:
      return #colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1)
    }
  }
}
