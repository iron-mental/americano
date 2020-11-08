//
//  UISegmentControl.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension UISegmentedControl {
  func clearBG() {
    let clearImage = UIImage().imageWithColor(color: .clear)
    setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
    setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
    setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
  }
}

public extension UIImage {
  public func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    guard let context = UIGraphicsGetCurrentContext() else { return UIImage()}
    context.setFillColor(color.cgColor)
    context.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
