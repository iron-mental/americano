//
//  LocationUIVIew.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class LocationUIView: UIView {
    var title = UILabel()
    var address = UILabel()
    var detailAddress = UITextField()
    var staroflifeImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    func attribute() {
        title.do {
            $0.text = "장소"
            $0.dynamicFont(fontSize: $0.font.pointSize, weight: .medium)
        }
        address.do {
            $0.sizeToFit()
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.text = "📍 장소 키워드 검색하러 가기"
            $0.setMargins(margin: 10)
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        detailAddress.do {
            $0.sizeToFit()
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.addLeftPadding(padding: 10)
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        staroflifeImageView.do {
            $0.image = UIImage(systemName: "staroflife.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.tintColor = UIColor.appColor(.mainColor)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func layout() {
        [title, address, detailAddress, staroflifeImageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        title.do {
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: $0.intrinsicContentSize.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width).isActive = true
        }
        staroflifeImageView.do {
            $0.topAnchor.constraint(equalTo: title.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: Terminal.convertWidth(value: 5)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 15)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 15)).isActive = true
        }
        address.do {
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeight(value: 17)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 45)).isActive = true
        }
        detailAddress.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: address.bottomAnchor, constant: Terminal.convertHeight(value: 17)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 45)).isActive = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
