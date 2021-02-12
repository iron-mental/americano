//
//  SnsInputUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class IdInputView: UIView {
    var titleLabel = UILabel()
    var notion = SNSInputItem()
    var evernote = SNSInputItem()
    var web = SNSInputItem()
    
    init() {
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    func attribute() {
        titleLabel.do {
            $0.text = "SNS"
            $0.dynamicFont(fontSize: $0.font.pointSize, weight: .medium)
        }
        notion.do {
            $0.textField.placeholder = "예) notion.so/example1234"
            $0.icon.image = #imageLiteral(resourceName: "notion")
        }
        evernote.do {
            $0.textField.placeholder = "예) evernote/example1234"
            $0.icon.image = #imageLiteral(resourceName: "evernote")
        }
        web.do {
            $0.textField.placeholder = "예) tistory/example1234"
            $0.icon.image = #imageLiteral(resourceName: "web")
        }
    }
    func layout() {
        [titleLabel, notion, evernote, web].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.do {
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: $0.intrinsicContentSize.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: $0.intrinsicContentSize.width).isActive = true
        }
        notion.do {
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                    constant: Terminal.convertHeigt(value: 17)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        evernote.do {
            $0.topAnchor.constraint(equalTo: notion.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        web.do {
            $0.topAnchor.constraint(equalTo: evernote.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
