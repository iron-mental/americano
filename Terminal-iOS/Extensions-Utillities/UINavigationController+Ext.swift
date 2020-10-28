//
//  UINavigationController+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationController {

  public func pushViewController(_ view: UIViewController,
                                 animated: Bool,
                                 completion: (() -> Void)?) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(view, animated: animated)
    CATransaction.commit()
  }

}
