//
//  BottomView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class BottomView: UIView {
    var address = UILabel()
    var detailAddress = UITextField()
    var completeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .appColor(.terminalBackground)
        }
        address.do {
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        detailAddress.do {
            $0.placeholder = "상세주소를 입력하세요"
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        completeButton.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.titleLabel?.dynamicFont(fontSize: 17, weight: .bold)
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
        }
    }
    
    func layout() {
        [address, detailAddress, completeButton].forEach { addSubview($0) }
        
        address.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor,
                                        constant: Terminal.convertWidth(value: 30)).isActive = true
            $0.topAnchor.constraint(equalTo: topAnchor,
                                    constant: Terminal.convertHeight(value: 20)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 320)).isActive = true
        }
        detailAddress.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: address.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 25)).isActive = true
            $0.leadingAnchor.constraint(equalTo: address.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 320)).isActive = true
        }
        completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor,
                                       constant: -Terminal.convertHeight(value: 40)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 324)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 45)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
