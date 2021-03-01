//
//  ApplyListCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class ApplyListCell: UITableViewCell {
    lazy var mainImage = UIImageView()
    var title = UILabel()
    var contents = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        attribute()
        layout()
    }
    
    func attribute() {
        self.mainImage.do {
            $0.image = UIImage(systemName: "person.crop.circle")?
                .withConfiguration(UIImage.SymbolConfiguration(weight: .ultraLight))
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .gray
        }
        self.title.do {
            $0.numberOfLines = 0
            $0.textColor = .systemGray2
            $0.dynamicFont(fontSize: 12, weight: .semibold)
        }
        self.contents.do {
            $0.numberOfLines = 3
            $0.textColor = .white
            $0.text = ""
            $0.numberOfLines = 1
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
    }
    
    func layout() {
        [mainImage, title, contents].forEach { self.contentView.addSubview($0) }
        self.mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 53)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 53)).isActive = true
        }
        self.title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeight(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.mainImage.trailingAnchor, constant: 23).isActive = true
        }
        self.contents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Terminal.convertHeight(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.mainImage.trailingAnchor, constant: 23).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 200)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
