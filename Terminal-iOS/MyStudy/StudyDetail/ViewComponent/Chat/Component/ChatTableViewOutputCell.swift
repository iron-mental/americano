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
            $0.placeholder = "_"
        }
    }
    
    func layout() {
        [textInput].forEach { contentView.addSubview($0) }
        
        textInput.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
