//
//  SearchLocationTableViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchLocationTableViewCell: UITableViewCell {
    static let identifier = "SearchLocationTableViewCell"
    
    var title = UILabel()
    var category = UILabel()
    var detailAddress = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 72)).isActive = true
        }
        title.do {
            $0.text = "넥슨"
            $0.textColor = UIColor.appColor(.mainColor)
            $0.font = UIFont.boldSystemFont(ofSize: 20)
        }
        category.do {
            $0.text = "게임제작"
            $0.textColor = .gray
            $0.font.withSize(14)
        }
        detailAddress.do {
            $0.text = "경기 성남시 분당구 판교로 394-3"
            $0.font.withSize(18)
        }
    }
    
    func layout() {
        [title, category, detailAddress].forEach { addSubview($0) }
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor,constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 48)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 17).isActive = true
        }
        category.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: Terminal.convertWidth(value: 21.9)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 13).isActive = true
        }
        detailAddress.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeigt(value: 40.9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 26).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
