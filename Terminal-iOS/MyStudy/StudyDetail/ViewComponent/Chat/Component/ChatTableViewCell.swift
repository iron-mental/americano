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
        if chat.nickname == "__SYSTEM__" {
            chatLabel.text = "SYSTEM $ \(chat.message)"
            chatLabel.textColor = .appColor(.mainColor)
            chatLabel.textAlignment = .center
        } else {
            chatLabel.text = "\(chat.nickname) $ \(chat.message)"
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
