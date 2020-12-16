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
    
    init() {
        super.init(frame: .zero)
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
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.addLeftPadding()
            $0.dynamicFont(fontSize: textField.font!.pointSize, weight: .thin)
        }
    }
    
    func layout() {
        [icon, textField].forEach { addSubview($0) }
        addSubview(icon)
        addSubview(textField)

        icon.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 20)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 20)).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: $0.intrinsicContentSize.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
