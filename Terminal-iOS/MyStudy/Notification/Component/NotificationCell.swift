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
    let action = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    func setData(noti: Noti) {
        self.explain.text = noti.message
    }
    
    func attribute() {
        title.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 16, weight: .semibold)
            $0.numberOfLines = 1
        }
        explain.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 14, weight: .regular)
            $0.numberOfLines = 1
        }
        action.do {
            $0.setTitleColor(UIColor.appColor(.mainColor), for: .normal)
        }
    }
    func layout() {
        addSubview(title)
        addSubview(explain)
        addSubview(action)
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeigt(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Terminal.convertWidth(value: 20)).isActive = true
        }
        explain.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeigt(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Terminal.convertWidth(value: 100)).isActive = true
        }
        action.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Terminal.convertWidth(value: 20)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
