//
//  UIImage+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageFromUIBarButtonItem(systemItem: UIBarButtonItem.SystemItem) -> UIImage? {
        let sysBarButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)
        let toolBar = UIToolbar()
        toolBar.setItems([sysBarButtonItem], animated: false)
        toolBar.snapshotView(afterScreenUpdates: true)
        
        if let buttonView = sysBarButtonItem.value(forKey: "view") as? UIView {
            for subView in buttonView.subviews where subView is UIButton {
                if let button = subView as? UIButton {
                    
                    let image = button.imageView!.image!
                    return image
                }
            }
        }
        return nil
    }
}
