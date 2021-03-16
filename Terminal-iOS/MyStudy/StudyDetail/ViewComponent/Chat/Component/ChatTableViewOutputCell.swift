//
//  ChatTableViewCell.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/23.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ChatOutputTableViewCell: UITableViewCell {
    static var id = "ChatOutputTableViewCell"
    var textInput = UITextField()
    var dallarLabel = UILabel()
    
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
        textInput.do {
            $0.textColor = .white
            $0.font = UIFont.monospacedSystemFont(ofSize: textInput.font!.pointSize, weight: UIFont.Weight.regular)
            $0.tintColor = .none
            $0.backgroundColor = .appColor(.InputViewColor)
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
            $0.addLeftPadding(padding: 10)
        }
        dallarLabel.do {
            $0.textColor = .white
            $0.text = "$"
            $0.font = UIFont.monospacedSystemFont(ofSize: textInput.font!.pointSize, weight: UIFont.Weight.regular)
        }
    }
    
    func layout() {
        [dallarLabel, textInput].forEach { contentView.addSubview($0) }
        
        dallarLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width).isActive = true
        }
        textInput.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: dallarLabel.trailingAnchor, constant: 3).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
