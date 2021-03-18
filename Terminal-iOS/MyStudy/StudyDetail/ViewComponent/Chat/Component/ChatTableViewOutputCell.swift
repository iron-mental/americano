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
    var textInput = UITextView()
    var dallarLabel = UILabel()
    var sendButton = UIButton()
    var cursorView = UIView()
    var twinkleFlag = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
        twinkleCursor()
    }
    
    @objc func twinkleCursor() {
        cursorView.backgroundColor =
            cursorView.backgroundColor == .white
            ? .appColor(.terminalBackground)
            : .white
        if twinkleFlag {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
                self.twinkleCursor()
            }
        }
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.selectionStyle = .none
        }
        textInput.do {
            $0.textColor = .white
            $0.tintColor = .clear
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.returnKeyType = .default
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.delegate = self
        }
        dallarLabel.do {
            $0.textColor = .white
            $0.text = "$"
        }
        sendButton.do {
            $0.tintColor = .lightGray
            $0.backgroundColor = .clear
            $0.setImage(UIImage(systemName: "arrow.up")?
                            .withConfiguration(UIImage.SymbolConfiguration(weight: .regular)),
                        for: .normal)
            $0.setImage(UIImage(systemName: "arrow.up")?
                            .withConfiguration(UIImage.SymbolConfiguration(weight: .regular)),
                        for: .disabled)
            $0.layer.cornerRadius = (self.frame.height - 10) / 2
            $0.layer.masksToBounds = true
        }
        cursorView.do {
            $0.backgroundColor = .white
        }
    }
    
    func layout() {
        [dallarLabel, textInput, sendButton, cursorView].forEach { contentView.addSubview($0) }
        
        dallarLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor,
                                        constant: Terminal.convertWidth(value: 5)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width).isActive = true
        }
        cursorView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalTo: textInput.heightAnchor,
                                       constant: -Terminal.convertHeight(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 5)).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: dallarLabel.trailingAnchor,
                                        constant: Terminal.convertWidth(value: 10)).isActive = true
        }
        textInput.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: cursorView.trailingAnchor, constant: 1).isActive = true
            $0.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
            $0.heightAnchor.constraint(equalTo: heightAnchor,
                                       constant: -Terminal.convertHeight(value: 10)).isActive = true
        }
        sendButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 10)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: self.frame.height - 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: self.frame.height - 10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatOutputTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        twinkleFlag = false
        cursorView.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        twinkleFlag = true
        cursorView.isHidden = false
        cursorView.backgroundColor = .white
        twinkleCursor()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        sendButton.tintColor = text.isEmpty ? .lightGray : .appColor(.mainColor)
        return true
    }
}
