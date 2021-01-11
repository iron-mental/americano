//
//  LocationView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class LocationView: UIView {
    let location = UILabel()
    let modify = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.location.do {
            $0.numberOfLines = 0
            $0.textColor = UIColor.appColor(.profileTextColor)
        }
        self.modify.do {
            $0.setTitle("수정", for: .normal)
            $0.setTitleColor(.appColor(.mainColor), for: .normal)
        }
    }
    func layout() {
        self.addSubview(location)
        self.addSubview(modify)
        
        self.location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
        self.modify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
