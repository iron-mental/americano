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
    var notion: SNSInputItem?
    var evernote: SNSInputItem?
    var web: SNSInputItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        notion = SNSInputItem(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: (25/118) * frame.size.height))
        evernote = SNSInputItem(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: (25/118) * frame.size.height))
        web = SNSInputItem(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: (25/118) * frame.size.height))
        
        attribute()
        layout()
    }
    
    func attribute() {
        titleLabel.do {
            $0.text = "SNS"
        }
        notion!.do {
            $0.textField.text = "notion"
        }
        evernote!.do {
            $0.textField.text = "evernote"
        }
        web!.do {
            $0.textField.text = "web"
        }
    }
    func layout() {
        addSubview(titleLabel)
        addSubview(notion!)
        addSubview(evernote!)
        addSubview(web!)
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (18/117) * frame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (31/352) * frame.width).isActive = true
        }
        notion!.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: (28/121) * frame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (22/121) * frame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (22/352) * frame.width).isActive = true
        }
        evernote!.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: notion!.bottomAnchor, constant: (10/121) * frame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (22/121) * frame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (22/352) * frame.width).isActive = true
        }
        web!.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: evernote!.bottomAnchor, constant: (10/121) * frame.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (22/121) * frame.height).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (22/352) * frame.width).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
