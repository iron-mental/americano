//
//  ChatTableViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ChatInputTableViewCell: UITableViewCell {
    static var id = "ChatInputTableViewCell"
    var chatLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.selectionStyle = .none
        }
        chatLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .white
            $0.font = UIFont.monospacedSystemFont(ofSize: chatLabel.font.pointSize-4, weight: UIFont.Weight.regular)
        }
    }
    
    func layout() {
        [chatLabel].forEach { addSubview($0) }
        
        chatLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
    
    func setData(chat: Chat) {
        if chat.userID == 0 {

            chatLabel.text = "\(chat.message)"
            chatLabel.textColor = .appColor(.mainColor)
            chatLabel.textAlignment = .center
        } else {
            guard let nickname = chat.nickname else { return }
            guard let message = chat.message else { return }
            chatLabel.text = convertTime(timeStamp: chat.date) + " \(nickname) $ \(message)"
            chatLabel.textColor = .white
            chatLabel.textAlignment = .left
        }
    }
    
    func convertTime(timeStamp: Int) -> String {
        let calender = Calendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp) / 1000)
        let hour = "\(calender.component(.hour, from: date))"
        let minute = "\(calender.component(.minute, from: date))"
        return "[\(hour.count == 2 ? hour : "0"+hour):\(minute.count == 2 ? minute : "0"+minute)]"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
