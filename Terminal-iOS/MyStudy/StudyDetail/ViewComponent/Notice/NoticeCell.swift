//
//  NoticeCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeCell: UITableViewCell {
    static let noticeCellID = "NoticeCellID"
    
    lazy var noticeBackground = UIView()
    lazy var noticeState = UILabel()
    lazy var noticeTitle = UILabel()
    lazy var noticeContent = UILabel()
    lazy var dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    override func prepareForReuse() {
        noticeBackground.backgroundColor = UIColor.appColor(.noticeColor)
        noticeState.text = "일반"
    }
    
    func setData(_ data: Notice) {
        if let isPinned = data.pinned,
           let updateAt = data.updatedAt,
           let title = data.title,
           let contents = data.contents {
            self.noticeState.text = isPinned ? "필독" : "일반"
            self.noticeBackground.backgroundColor = isPinned ? UIColor.appColor(.pinnedNoticeColor) : UIColor.appColor(.noticeColor)
            noticeTitle.do {
                $0.text = title
            }
            noticeContent.do {
                $0.text = contents
                $0.numberOfLines = 4
            }
            dateLabel.do {
                $0.text = "작성일 : \(updateAt)"
            }
            
        }
        
    }
    
    func attribute() {
        self.do {
            $0.selectionStyle = .none
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        noticeBackground.do {
            $0.backgroundColor = UIColor.appColor(.noticeColor)
            $0.layer.cornerRadius = 5
        }
        noticeState.do {
            $0.dynamicFont(fontSize: 11, weight: .regular)
            $0.text = "일반"
            $0.textAlignment = .center
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
        }
        noticeTitle.do {
            $0.dynamicFont(fontSize: 14, weight: .regular)
            $0.textColor = .white
        }
        noticeContent.do {
            $0.dynamicFont(fontSize: 14, weight: .regular)
            $0.numberOfLines = 0
        }
        dateLabel.do {
            $0.dynamicFont(fontSize: 12, weight: .regular)
            $0.textColor = UIColor.appColor(.studySubTitle)
        }
    }
    func layout() {
        [ noticeBackground, noticeTitle, noticeContent, dateLabel ].forEach { addSubview($0) }
        noticeBackground.addSubview(noticeState)
        
        noticeBackground.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Terminal.convertHeight(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Terminal.convertHeight(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 41)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 20)).isActive = true
        }
        noticeState.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: noticeBackground.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: noticeBackground.centerYAnchor).isActive = true
        }
        noticeTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.noticeBackground.trailingAnchor, constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
            $0.centerYAnchor.constraint(equalTo: noticeBackground.centerYAnchor).isActive = true
        }
        noticeContent.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13).isActive = true
            $0.topAnchor.constraint(equalTo: self.noticeTitle.bottomAnchor, constant: 10).isActive = true
//            $0.bottomAnchor.constraint(lessThanOrEqualTo: self.dateLabel.topAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
        dateLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Terminal.convertHeight(value: 5)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Terminal.convertWidth(value: 12)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
