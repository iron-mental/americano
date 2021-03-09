//
//  AlertMessageView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class AlertMessageView: AlertBaseUIView {
    var alertMessageLabel = UILabel()
    var alertMessage = ""
    
    init(message: String) {
        super.init()
        alertMessage = message
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attribute() {
        super.attribute()
        alertMessageLabel.do {
            $0.numberOfLines = 3
            $0.textAlignment = .center
            $0.textColor = .white
            $0.dynamicFont(fontSize: 13, weight: .regular)
            $0.text = alertMessage
        }
    }
    
    override func layout() {
        super.layout()
        [ alertMessageLabel ].forEach {addSubview($0)}
        
        alertMessageLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: bottomBar.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor, constant: -20).isActive = true
        }
    }
    
    func onlyCompleteButton() {
        dismissButton.isHidden = true
        completeButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor).isActive = true
    }
    
    func dynamicLabelFontSize() {}
}
