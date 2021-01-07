//
//  SNSView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSView: UIView {
    
    let snsStack = UIStackView()
    let snsImage = UIImageView()
    var firstWidth: NSLayoutConstraint!
    var secondWidth: NSLayoutConstraint!
    var thirdWidth: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.snsImage.do {
            $0.image = #imageLiteral(resourceName: "github")
        }
        self.snsStack.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
    }
    
    func layout() {
        self.addSubview(self.snsStack)

        self.snsStack.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
        
        self.firstWidth = self.snsStack.widthAnchor.constraint(equalToConstant: 30)
        self.firstWidth.isActive = false
        
        self.secondWidth = self.snsStack.widthAnchor.constraint(equalToConstant: 70)
        self.secondWidth.isActive = false
        
        self.thirdWidth = self.snsStack.widthAnchor.constraint(equalToConstant: 110)
        self.thirdWidth.isActive = false
    }
    
    // override point
    func addstack(snsList: [String: String]) {

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
