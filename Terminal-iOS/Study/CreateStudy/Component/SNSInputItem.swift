//
//  SnsInputItem.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSInputItem: UIView {
    var icon = UIImageView()
    var textField = SNSInputUITextField()
    var valid = UIImageView()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    func attribute() {
        icon.do {
            $0.image = #imageLiteral(resourceName: "notion")
            $0.contentMode = .scaleAspectFit
        }
        textField.do {
            
            $0.placeholder = "이거 플레이스홀더에연"
            $0.sizeToFit()
            $0.backgroundColor = .red
        }
        valid.do {
            //            $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            $0.image = #imageLiteral(resourceName: "Vaild")
        }
    }
    
    func layout() {
        addSubview(icon)
        addSubview(textField)
        addSubview(valid)
        
        //각각 길이 화면대응 해주어야 합니다.
        icon.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 31).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 70).isActive = true
        }
        valid.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
