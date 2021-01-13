//
//  LocationCell.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/08.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class LocationCell: UICollectionViewCell {
    static let cellID = "locationCellID"
    let address = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func setData(data: String) {
        self.address.do {
            $0.setTitle(data, for: .normal)
            $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 13)
        }
    }
    
    private func attribute() {
        self.contentView.isUserInteractionEnabled = false
        address.do {
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.backgroundColor = .appColor(.cellBackground)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
        }
    }
    
    private func layout() {
        self.contentView.addSubview(address)
        
        self.address.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
