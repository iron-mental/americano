//
//  CarrerView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CareerView: UIView {
    let emptyMessage = UILabel()
    let careerTitle = UILabel()
    let careerContents = UILabel()
    let modify = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
   
    func attribute() {
        self.do {
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        self.emptyMessage.do {
            $0.text = "경력이 존재하지 않습니다."
            $0.dynamicFont(fontSize: 15, weight: .medium)
            $0.textColor = .white
        }
        self.careerTitle.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 16, weight: .bold)
        }
        self.careerContents.do {
            $0.numberOfLines = 0
            $0.textColor = .appColor(.profileTextColor)
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
        self.modify.do {
            $0.setTitle("수정", for: .normal)
            $0.setTitleColor(.appColor(.mainColor), for: .normal)
        }
    }
    
    func layout() {
        [emptyMessage, careerTitle, careerContents, modify].forEach { self.addSubview($0) }
        
        self.emptyMessage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
        self.careerTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.modify.leadingAnchor, constant: -5).isActive = true
        }
        self.careerContents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.careerTitle.bottomAnchor, constant: 4).isActive = true
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
