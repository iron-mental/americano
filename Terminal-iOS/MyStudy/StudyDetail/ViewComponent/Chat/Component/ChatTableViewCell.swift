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
//    var textInput = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        chatLabel.do {
            $0.textColor = .white
            $0.font = UIFont.monospacedSystemFont(ofSize: chatLabel.font.pointSize-4, weight: UIFont.Weight.regular)
        }
//        textInput.do {
//            $0.textColor = .white
////            $0.font = UIFont.monospacedSystemFont(ofSize: chatLabel.font.pointSize, weight: UIFont.Weight.regular)
//            $0.isHidden = true
//            $0.placeholder = "_"
//        }
    }
    
    func layout() {
        [chatLabel].forEach { addSubview($0) }
//        [textInput].forEach { addSubview($0) }
        chatLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
//        textInput.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
//            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
////            $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
