//
//  DefalutCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class DefalutCell: UITableViewCell {
    static let cellId = "defaltCell"
    
    let title = UILabel()
    let rightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: Setting){
        self.title.text = data.title
    }
    
    func attribute() {
        title.do {
            $0.textAlignment = .center
            $0.font = $0.font.withSize(12)
            $0.textColor = .black
        }
        
        rightLabel.do {
            $0.textAlignment = .center
            $0.font = $0.font.withSize(12)
        }
    }
    
    func layout() {
        addSubview(title)
        addSubview(rightLabel)
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        }
        
        rightLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        }
    }
}
