//
//  DefalutCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class DefaultCell: UITableViewCell {
    static let defalutCellId = "defaltCell"
    
    lazy var title = UILabel()
    lazy var rightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.appColor(.cellBackground)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: Setting){
        title.do {
            $0.text = data.title
        }
        rightLabel.do {
            $0.text = data.status
        }
    }
    
    func attribute() {        
        title.do {
            $0.textAlignment = .center
            $0.textColor = .white
        }
        rightLabel.do {
            $0.textAlignment = .right
            $0.textColor = .white
        }
    }
    
    func layout() {
        self.contentView.addSubview(title)
        self.contentView.addSubview(rightLabel)
        
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
