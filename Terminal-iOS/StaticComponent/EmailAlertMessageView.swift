//
//  EmailAlertMessageView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/18.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class EmailAlertMessageView: AlertBaseUIView {
    
    var alertMessageLabel = UILabel()
    var message: String?
    
    init(message: String) {
        super.init()
        self.message = message
        attribute()
        layout()
    }
    
    override func attribute() {
        super.attribute()
        alertMessageLabel.do {
            $0.textColor = UIColor.appColor(.alertTextcolor)
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.dynamicFont(fontSize: 13, weight: .regular)
            $0.text = self.message ?? ""
        }
    }
    
    override func layout() {
        super.layout()
        self.addSubview(alertMessageLabel)
        
        alertMessageLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
