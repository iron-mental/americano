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
    let modify = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        addstack()
    }
    
    func attribute() {
        snsImage.do {
            $0.image = #imageLiteral(resourceName: "github")
        }
        snsStack.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
        modify.do {
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
    }
    
    func addstack() {
        let github = UIButton().then {
            $0.setImage(#imageLiteral(resourceName: "github"), for: .normal)
        }
        let linked = UIButton().then {
            $0.setImage(#imageLiteral(resourceName: "web"), for: .normal)
        }
        let web = UIButton().then {
            $0.setImage(#imageLiteral(resourceName: "blog"), for: .normal)
        }
        
        snsStack.addArrangedSubview(github)
        snsStack.addArrangedSubview(linked)
        snsStack.addArrangedSubview(web)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
