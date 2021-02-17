//
//  badgeUIBarButtonItem.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class BadgeBarButtonItem: UIBarButtonItem {
    var badgeLabel = UILabel(frame: CGRect(x: -10, y: -5, width: 16, height: 16))
    var button = UIButton()
    
    func attribute() {
        badgeLabel.do {
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = badgeLabel.bounds.size.height / 2
            $0.textAlignment = .center
            $0.layer.masksToBounds = true
            $0.font = UIFont.systemFont(ofSize: 10)
            $0.textColor = .white
            $0.backgroundColor = .systemRed
            $0.isHidden = true
        }
        button.do {
            $0.imageView?.contentMode = .scaleAspectFit
            $0.setBackgroundImage(UIImage(systemName: "envelope"), for: .normal)
            
            $0.addSubview(badgeLabel)
        }
        self.do {
            $0.customView = button
        }
    }
    
    override init() {
        super.init()
        attribute()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
