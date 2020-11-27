//
//  CarrerView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CarrerView: UIView {
    let careerLabel = UILabel()
    let careerTitle = UILabel()
    let careerContents = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
   
    func attribute() {
        careerLabel.do {
            $0.text = "경력"
            $0.textColor = .white
        }
        careerTitle.do {
//            $0.text = "OO대학교 4학년 재학중"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 16, weight: .bold)
        }
        careerContents.do {
//            $0.text = "경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다.경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다."
            $0.numberOfLines = 0
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
    }
    
    func layout() {
        addSubview(careerLabel)
        addSubview(careerTitle)
        addSubview(careerContents)
        
        careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        careerTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.careerLabel.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        careerContents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerTitle.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
