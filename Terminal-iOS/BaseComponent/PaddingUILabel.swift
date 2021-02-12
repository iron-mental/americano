//
//  PaddingUILabel.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    var padding: UIEdgeInsets?
    
    init(insets: UIEdgeInsets = UIEdgeInsets(top: 15, left: 8, bottom: 15, right: 8)) {
        super.init(frame: CGRect.zero)
        padding = insets
        attribute()
    }
    
    func attribute() {
        self.do {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    override func drawText(in rect: CGRect) {
        let paddingRect = rect.inset(by: padding!)
        super.drawText(in: paddingRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding!.top + padding!.bottom
        contentSize.width += padding!.left + padding!.right
        return contentSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
