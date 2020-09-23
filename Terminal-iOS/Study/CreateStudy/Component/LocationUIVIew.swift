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
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    func attribute() {
        title.do {
            $0.text = "장소"
        }
        detailAddress.do {
            $0.text = "상세 위치"
        }
    }
    
    func layout() {
        addSubview(title)
        addSubview(detailAddress)
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        detailAddress.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
