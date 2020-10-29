//
//  tabButtonCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class tabButtonCell: UICollectionViewCell {
    static let cellID = "tabButtonID"
    
    let state = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        state.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 14, weight: .medium)
            $0.textAlignment = .center
        }
    }
    func layout() {
        state.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
