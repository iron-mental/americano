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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        icon.do {
            $0.image = #imageLiteral(resourceName: "notion")
            //height을 따로 지정해줘야 하는건가? 컨텐트 모드만 지정해주면 width에 맞춰 알아서하는건가?
            $0.frame = CGRect(x: 0, y: 0, width: (20/345) * bounds.width, height: 0)
            $0.contentMode = .scaleAspectFit
        }
        textField.do {
            $0.placeholder = "이거 플레이스홀더에연"
            $0.sizeToFit()
            $0.backgroundColor = .red
        }
        valid.do {
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
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor,constant: -100).isActive = true
        }
        valid.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
