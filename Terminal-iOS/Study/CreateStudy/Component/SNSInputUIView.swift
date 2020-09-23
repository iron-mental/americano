//
//  SnsInputUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSInputUIVIew: UIView {
    var notion =  SNSInputItem()
    var evernote =  SNSInputItem()
    var web =  SNSInputItem()
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        attribute()
        layout()
    }
    
    func attribute() {
        notion.do {
            $0.textField.text = "notion"
        }
        evernote.do {
            $0.textField.text = "evernote"
        }
        web.do {
            $0.textField.text = "web"
        }
    }
    func layout() {
        addSubview(notion)
        addSubview(evernote)
        addSubview(web)
        
        notion.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        }
        evernote.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: notion.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: evernote.topAnchor,constant: 30).isActive = true
        }
        web.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: evernote.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: web.topAnchor, constant: 30).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
