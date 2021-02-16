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
    
    let iconLabel = UILabel()
    let titleLabel = UILabel()
    let explainLabel = UILabel()
    let timeLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func setData(noti: Noti) {
        switch AlarmCase(rawValue: noti.pushEvent) {
        case .applyAllowed:
            iconLabel.text = "🎉"
        case .applyRejected:
            iconLabel.text = "😭"
        case .studyDelete:
            iconLabel.text = "‼️"
        case .newApply:
            iconLabel.text = "✉️"
        case .newNotice, .updatedNotice:
            iconLabel.text = "📌"
        case .studyUpdate:
            iconLabel.text = "✏️"
        case .studyHostDelegate:
            iconLabel.text = "🙋🏻"
        case .chat, .undefined, .testPush, .none: break
        }
        
        self.titleLabel.text = noti.studyTitle
        self.explainLabel.text = noti.message
        self.backgroundColor = noti.confirm ? .clear : .systemGray5
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.selectionStyle = .none
        }
        
        self.iconLabel.do {
            $0.dynamicFont(fontSize: 14, weight: .bold)
        }
        
        self.titleLabel.do {
            $0.textColor = .systemGray
            $0.dynamicFont(fontSize: 14, weight: .bold)
            $0.numberOfLines = 1
        }
        self.explainLabel.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 20, weight: .regular)
            $0.numberOfLines = 1
        }
        self.timeLabel.do {
            $0.text = "3일 전"
            $0.textColor = .systemGray
            $0.dynamicFont(fontSize: 14, weight: .bold)
        }
    }
    
    func layout() {
        [iconLabel, titleLabel, timeLabel, explainLabel].forEach { self.addSubview($0) }
        
        self.iconLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
            //            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 20)).isActive = true
            //            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 20)).isActive = true
        }
        
        self.titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor,
                                    constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.iconLabel.trailingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
        }
        
        self.timeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor,
                                    constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 15)).isActive = true
        }
        self.explainLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 20)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.iconLabel.trailingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 100)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
