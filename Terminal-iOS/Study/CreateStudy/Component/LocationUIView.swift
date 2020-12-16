//
//  LocationUIVIew.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class LocationUIVIew: UIView {
    var title = UILabel()
    var detailAddress = UILabel()
    var locationdetailTextField = UITextField()
    
    init() {
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    func attribute() {
        title.do {
            $0.text = "장소"
            $0.dynamicFont(fontSize: $0.font.pointSize , weight: .medium)
        }
        detailAddress.do {
            $0.sizeToFit()
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        locationdetailTextField.do {
            $0.sizeToFit()
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.addLeftPadding()
        }
    }
    
    func layout() {
        [title, detailAddress, locationdetailTextField].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        title.do {
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: $0.intrinsicContentSize.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width).isActive = true
        }
        detailAddress.do {
            $0.topAnchor.constraint(equalTo: title.bottomAnchor,constant: Terminal.convertHeigt(value: 17)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        }
        locationdetailTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: detailAddress.bottomAnchor, constant: Terminal.convertHeigt(value: 17)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
