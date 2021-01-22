//
//  DelegateHostTableViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/22.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import Kingfisher

class DelegateHostTableViewCell: UITableViewCell {
    static let id = "DelegateHostTableViewCell"
    var profileImage = UIImageView()
    var nickname = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        profileImage.do {
            $0.layer.cornerRadius = Terminal.convertWidth(value: 46) / 2
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.borderWidth = 0.3
            $0.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func layout() {
        [ profileImage, nickname ].forEach { addSubview($0) }
        
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 46)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 46)).isActive = true
        }
        nickname.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
