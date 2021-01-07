//
//  SNSView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSView: UIView {
    
    let github = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "github"), for: .normal)
    }
    let linkedin = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "web"), for: .normal)
    }
    let web = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "blog"), for: .normal)
    }
    
    let snsStack = UIStackView()
    let snsImage = UIImageView()
    let modify = UIButton()
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
        self.modify.do {
            $0.setTitle("수정", for: .normal)
            $0.setTitleColor(.appColor(.mainColor), for: .normal)
        }
    }
    
    func layout() {
        self.addSubview(self.snsStack)
        self.addSubview(self.modify)

        self.snsStack.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 110).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
        self.modify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        self.firstWidth = self.snsStack.widthAnchor.constraint(equalToConstant: 30)
        self.firstWidth.isActive = false
        
        self.secondWidth = self.snsStack.widthAnchor.constraint(equalToConstant: 70)
        self.secondWidth.isActive = false
        
        self.thirdWidth = self.snsStack.widthAnchor.constraint(equalToConstant: 110)
        self.thirdWidth.isActive = false
    }
    
    func addstack(snsList: [String: String]) {
        var count = 0
        if let _ = snsList["github"] {
            self.snsStack.addArrangedSubview(self.github)
            count += 1
        }
        
        if let _ = snsList["linkedin"] {
            self.snsStack.addArrangedSubview(self.linkedin)
            count += 1
        }
        
        if let _ = snsList["web"] {
            self.snsStack.addArrangedSubview(self.web)
            count += 1
        }
        
        switch count {
        case 1:
            self.firstWidth.isActive = true
        case 2:
            self.secondWidth.isActive = true
        case 3:
            self.thirdWidth.isActive = true
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
