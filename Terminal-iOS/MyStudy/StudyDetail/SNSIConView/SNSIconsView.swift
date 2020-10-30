//
//  File.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSIconsView: UIView {
    var notion = SNSIconImageView()
    var evernote = SNSIconImageView()
    var web = SNSIconImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        notion.do {
            $0.image = #imageLiteral(resourceName: "notion")
            $0.contentMode = .scaleToFill
        }
        evernote.do {
            $0.image = #imageLiteral(resourceName: "evernote")
            $0.contentMode = .scaleToFill
        }
        web.do {
            $0.image = #imageLiteral(resourceName: "web")
            $0.contentMode = .scaleToFill
        }
    }
    
    func layout() {
        [notion, evernote, web].forEach { addSubview($0) }
        
        notion.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        evernote.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: notion.trailingAnchor, constant: Terminal.convertWidth(value: 8)).isActive = true
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        web.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: evernote.trailingAnchor, constant: Terminal.convertWidth(value: 8)).isActive = true
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
