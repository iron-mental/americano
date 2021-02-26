//
//  UIApplication+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let nav = base as? UINavigationController {
            if let visibleViewController = nav.visibleViewController {
                if type(of: visibleViewController) == UIAlertController.self {
                    return getTopViewController(base: nav.viewControllers[nav.viewControllers.count - 1])
                }
                return getTopViewController(base: nav.visibleViewController)
            }
        }
        if let presented = base?.presentedViewController {
            if type(of: presented) == UIAlertController.self ||
                type(of: presented) == UISearchController.self {
                return base
            }
            return getTopViewController(base: presented)
        }
        return base
    }
}
