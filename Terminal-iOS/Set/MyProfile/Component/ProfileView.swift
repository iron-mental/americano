//
//  ProfileView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    let profileImage = UIImageView()
    let name = UILabel()
    let descript = UILabel()
    let modify = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.layer.borderWidth = 0.2
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        profileImage.do {
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertHeight(value: 100)
            $0.frame.size.height = Terminal.convertHeight(value: 100)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
        name.do {
            $0.textColor = .white
            $0.textAlignment = .center
            $0.dynamicFont(fontSize: 20, weight: .semibold)
        }
        descript.do {
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.dynamicFont(fontSize: 16, weight: .regular)
        }
        modify.do {
            $0.setTitle("수정", for: .normal)
            $0.setTitleColor(.appColor(.mainColor), for: .normal)
        }
    }
    
    func layout() {
        [profileImage, name, descript, modify].forEach { self.addSubview($0) }
        
        self.profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
        }
        self.name.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        self.descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 7).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
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
