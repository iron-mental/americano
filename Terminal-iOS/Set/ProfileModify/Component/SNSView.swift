//
//  SNSView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSView: UIView {
    let snsLabel = UILabel()
    let snsStack = UIStackView()
    let snsImage = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        snsLabel.do {
            $0.text = "SNS"
            $0.textColor = .white
        }
        snsImage.do {
            $0.image = #imageLiteral(resourceName: "github")
        }
    }
    
    func layout() {
        addSubview(snsLabel)
        addSubview(snsImage)
        
        snsLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        snsImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsLabel.bottomAnchor, constant: 5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
