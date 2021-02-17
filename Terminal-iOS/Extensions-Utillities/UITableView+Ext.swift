//
//  UITableView+Ext.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyView(type: EmptyViewCase) {
        type.view.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        self.backgroundView = type.view
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
