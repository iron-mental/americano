//
//  UIApplication+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication
                                    .shared
                                    .windows
                                    .first(where: { $0.isKeyWindow })?
                                    .rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
