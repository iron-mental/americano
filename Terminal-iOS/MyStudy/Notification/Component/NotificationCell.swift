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
    
    let now = Date()
    let date = DateFormatter()
    
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
        self.timeLabel.text = convertToElapsedTime(notificationTime: noti.createdAt)
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.selectionStyle = .none
        }
        
        self.iconLabel.do {
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
        
        self.titleLabel.do {
            $0.textColor = .systemGray
            $0.dynamicFont(fontSize: 14, weight: .regular)
            $0.numberOfLines = 1
        }
        self.explainLabel.do {
            $0.textColor = .white
            $0.dynamicFont(fontSize: 14, weight: .regular)
            $0.numberOfLines = 1
        }
        self.timeLabel.do {
            $0.text = "3일 전"
            $0.textColor = .systemGray
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
    }
    
    func layout() {
        [iconLabel, titleLabel, timeLabel, explainLabel].forEach { self.addSubview($0) }
        
        self.iconLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
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
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 20)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 15)).isActive = true
        }
    }
    
    func convertToElapsedTime(notificationTime: String) -> String {
        //알림 시간 쪼개기
        let splitNotificationTime = notificationTime.components(separatedBy: " ")
        let notiDayArr =  split(target: splitNotificationTime[0], separateItem: "-")
        let notiTimeArr = split(target: splitNotificationTime[1], separateItem: ":")
        
        //현재 시간 쪼개기
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTimeToKR = date.string(from: now)

        let splitcurruntTime = "\(currentTimeToKR)".components(separatedBy: " ")
        let currentDayArr = split(target: splitcurruntTime[0], separateItem: "-")
        let currentTimeArr = split(target: splitcurruntTime[1], separateItem: ":")
        
        if currentDayArr[0] - notiDayArr[0] > 0 {
//            년이 다름 (해가 바뀌는 순간엔 정확하진 않음 서버에서 timeStamp로 내려오지 않아 이정도에서 정리)
            return "\(notiDayArr[0] - currentDayArr[0])년 전"
        } else if currentDayArr[1] - notiDayArr[1] > 0 {
//            년은 같고 달이 다름
            return "\(currentDayArr[1] - notiDayArr[1])달 전"
        } else if currentDayArr[2] - notiDayArr[2] > 0 {
//            년,달 같고 일이 다름
            return "\(currentDayArr[2] - notiDayArr[2])일 전"
        } else if currentTimeArr[0] - notiTimeArr[0] > 0 {
//            년,달,일 같고 시간이 다름
            return "\(currentTimeArr[0] - notiTimeArr[0])시간 전"
        } else if currentTimeArr[1] - notiTimeArr[1] > 0 {
//            년,달,일,시간 같고 분이 다름
            return "\(currentTimeArr[1] - notiTimeArr[1])분 전"
        } else if currentTimeArr[2] - notiTimeArr[2] > 0 {
//            년,달,일,시간,분이 같고 초가 다름
            return "\(currentTimeArr[2] - notiTimeArr[2])초 전"
        }
        return ""
    }
    
    func split(target: String, separateItem: String) -> [Int] {
        let splitTarget = target.components(separatedBy: separateItem)
        let result = splitTarget.map { Int($0)! }
        return result
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
