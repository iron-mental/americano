//
//  UIScrollView+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToView(view: UIView, animated: Bool) {
        if let origin = view.superview {

                    // Get the Y position of your child view
                    let childStartPoint = origin.convert(view.frame.origin, to: self)
                    let bottomOffset = scrollBottomOffset()

                    if childStartPoint.y > bottomOffset.y {
                        setContentOffset(bottomOffset, animated: true)
                    } else {
                        setContentOffset(CGPoint(x: 0, y: childStartPoint.y), animated: true)
                    }
                }
        }
    private func scrollBottomOffset() -> CGPoint {
            return CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        }
}
