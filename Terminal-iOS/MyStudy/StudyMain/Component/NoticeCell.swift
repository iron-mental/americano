//
//  NoticeCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeCell: UITableViewCell {
    static let cellID = "NoticeCellID"
    
    lazy var noticeBackground = UIView()
    lazy var noticeLabel = UILabel()
    lazy var noticeTitle = UILabel()
    lazy var date = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        noticeBackground.do {
            $0.backgroundColor = UIColor.appColor(.noticeColor)
            $0.layer.cornerRadius = 5
        }
        noticeLabel.do {
            $0.dynamicFont(fontSize: 12, weight: .medium)
            $0.text = "공지"
            $0.textAlignment = .center
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
        }
        noticeTitle.do {
            $0.dynamicFont(fontSize: 14, weight: .semibold)
            $0.textColor = .white
        }
        date.do {
            $0.dynamicFont(fontSize: 10, weight: .medium)
            $0.textColor = UIColor.appColor(.studySubTitle)
        }
    }
    func layout() {
        addSubview(noticeBackground)
        noticeBackground.addSubview(noticeLabel)
        addSubview(noticeTitle)
        addSubview(date)
        noticeBackground.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeigt(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Terminal.convertHeigt(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 41)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        noticeLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: noticeBackground.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: noticeBackground.centerYAnchor).isActive = true
        }
        noticeTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.noticeBackground.trailingAnchor, constant: Terminal.convertWidth(value: 15)).isActive = true
        }
        date.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Terminal.convertWidth(value: 12)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
