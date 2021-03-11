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
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 72)).isActive = true
            $0.backgroundColor = .appColor(.terminalBackground)
        }
        title.do {
            $0.textColor = .appColor(.mainColor)
            $0.dynamicFont(fontSize: 16, weight: .regular)
            $0.sizeToFit()
        }
        category.do {
            $0.textAlignment = .right
            $0.textColor = .gray
            $0.dynamicFont(fontSize: 12, weight: .regular)
        }
        detailAddress.do {
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
    }
    
    func layout() {
        [title, category, detailAddress].forEach { addSubview($0) }
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor,
                                    constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        }
        category.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 21.9)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 200)).isActive = true
        }
        detailAddress.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor,
                                    constant: Terminal.convertHeight(value: 40.9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 26).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
