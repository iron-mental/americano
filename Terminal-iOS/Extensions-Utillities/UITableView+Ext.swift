//
//  UITableView+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyView(type: EmptyViewType) {
        type.view.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        self.backgroundView = type.view
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}
