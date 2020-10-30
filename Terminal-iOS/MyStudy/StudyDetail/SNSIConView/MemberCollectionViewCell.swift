//
//  MemberCollectionViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    static  let identifier = "cell"
    
    var profileImage = UIImageView()
    var nickname = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        profileImage.do {
            $0.layer.cornerRadius = Terminal.convertWidth(value: 46) / 2
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        nickname.do {
            $0.text = "테스트"
        }
    }
    
    func layout() {
        addSubview(profileImage)
        addSubview(nickname)
        
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 46)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 46)).isActive = true
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        nickname.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Terminal.convertHeigt(value: 4)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: nickname.intrinsicContentSize.height).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
