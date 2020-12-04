//
//  LocationModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/10.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class LocationModifyView: UIView {
    let locationLabel = UILabel()
    let locationTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .white
        }
        locationTextField.do {
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
    }
    func layout() {
        addSubview(locationLabel)
        addSubview(locationTextField)
        
        locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        }
        locationTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
