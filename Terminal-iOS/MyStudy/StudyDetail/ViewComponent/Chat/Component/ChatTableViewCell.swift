//
//  ChatTableViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

final class ChatInputTableViewCell: UITableViewCell {
    static var id = "ChatInputTableViewCell"
    var chatLabel = UILabel()
    var chevronLabel = UILabel()
        
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
        chevronLabel.do {
            $0.text = ">>"
            $0.textColor = .white
            $0.font = UIFont.monospacedSystemFont(ofSize: chatLabel.font.pointSize-4, weight: UIFont.Weight.regular)
        }
        chatLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .white
            $0.font = UIFont.monospacedSystemFont(ofSize: chatLabel.font.pointSize-4, weight: UIFont.Weight.regular)
        }
    }
    
    func layout() {
        [chevronLabel, chatLabel].forEach { addSubview($0) }
        
        chevronLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width).isActive = true
        }
        chatLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: chevronLabel.trailingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
    
    func setData(chat: Chat) {
        if chat.userID == 0 {
            chevronLabel.isHidden = true
            guard let message = chat.message else { return }
            chatLabel.do {
                $0.text = "\(message)"
                $0.textColor = .appColor(.mainColor)
                $0.textAlignment = .center
            }
        } else {
            guard let nickname = chat.nickname,
                  let message = chat.message,
                  let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
            chevronLabel.isHidden = !(chat.userID == Int(userID))
            chatLabel.text = convertTime(timeStamp: chat.date) + " \(nickname) $ \(message)"
            chatLabel.textAlignment = .left
            if let isTemp = chat.isTemp {
                if isTemp {
                    chatLabel.textColor = .lightGray
                } else {
                    chatLabel.text = chatLabel.text! + " - 전송실패"
                    chatLabel.textColor = .systemRed
                }
            } else {
                chatLabel.textColor = .white
            }
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
