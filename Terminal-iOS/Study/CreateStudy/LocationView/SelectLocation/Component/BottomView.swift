//
//  BottomView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class BottomView: UIView {
    var textField = UITextField()
    var searchButton = UIButton()
    var Address = UILabel()
    var detailAddress = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .systemBackground
        }
        textField.do {
            $0.placeholder = "상세주소 입력하시죠"
        }
        searchButton.do {
            $0.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        }
        Address.do {
            $0.text = "주소가 들어갈 공간이쥬"
        }
        detailAddress.do {
            $0.placeholder = "상세주소를 입력하세요"
        }
    }
    
    func layout() {
        [textField, searchButton, Address, detailAddress].forEach { addSubview($0) }
        
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor, constant: Terminal.convertHeigt(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 30)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 200)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: textField.intrinsicContentSize.height)).isActive = true
        }
        searchButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Terminal.convertWidth(value: 26)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 27)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 27)).isActive = true
        }
        Address.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: Terminal.convertHeigt(value: 16.1)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 320)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Address.intrinsicContentSize.height).isActive = true
        }
        detailAddress.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: Address.bottomAnchor, constant: Terminal.convertHeigt(value: 25)).isActive = true
            $0.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 320)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: detailAddress.intrinsicContentSize.height).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
