//
//  HotKeywordCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class HotKeywordCell: UICollectionViewCell {
    static let cellId = "HotKeywordCellId"
    let keyword = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.contentView.isUserInteractionEnabled = false
        keyword.do {
            $0.layer.borderWidth = 1
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.layer.cornerRadius = 10
            $0.titleLabel?.dynamicFont(fontSize: 14, weight: .medium)
        }
    }
    
    private func layout() {
        self.contentView.addSubview(keyword)
        keyword.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
}
