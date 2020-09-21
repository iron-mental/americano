//
//  SNSInputUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/20.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSInputUIView: UIView {
    var titleLabel = UILabel()
    var notion = SNSInputItem(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    var evernote = SNSInputItem(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    var web = SNSInputItem(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    func attribute() {
        titleLabel.do {
            $0.text = "SNS"
        }
        notion.do {
            $0.textField.backgroundColor = .red
        }
        evernote.do {
            $0.textField.backgroundColor = .green
        }
        web.do {
            $0.textField.backgroundColor = .blue
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(notion)
        addSubview(evernote)
        addSubview(web)
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        }
        notion.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor,constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        evernote.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: notion.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        web.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: evernote.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
