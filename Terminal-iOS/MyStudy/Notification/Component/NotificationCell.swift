//
//  NotificationCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    static let cellID = "NotificationCell"
    
    let title = UILabel()
    let explain = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func setData(noti: Noti) {
        self.title.text = noti.studyTitle
        self.explain.text = noti.message
        self.backgroundColor = noti.confirm ? .clear : .systemGray5
    }
    
    func attribute() {
        self.backgroundColor = .appColor(.terminalBackground)
        self.selectionStyle = .none
        self.title.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 20, weight: .bold)
            $0.numberOfLines = 1
        }
        self.explain.do {
            $0.textColor = .systemGray
            $0.dynamicFont(fontSize: 14, weight: .regular)
            $0.numberOfLines = 1
        }
    }
    
    func layout() {
        self.addSubview(title)
        self.addSubview(explain)
        
        self.title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor,
                                    constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
        }
        self.explain.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 100)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
