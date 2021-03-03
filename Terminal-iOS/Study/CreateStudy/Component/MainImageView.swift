//
//  File.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MainImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.isUserInteractionEnabled = true
        }
    }
    
    func layout() {
        self.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: Terminal.screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (170/667) * Terminal.screenSize.height).isActive = true
            $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func editMode() {
        let backgroundView = UIView()
        let editImageView = UIImageView()
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(editImageView)
        
        backgroundView.do {
            $0.backgroundColor = .darkGray
            $0.alpha = 0.5
            $0.frame = CGRect(x: 0,
                              y: 0,
                              width: self.constraints[0].constant,
                              height: self.constraints[1].constant)
        }
        editImageView.do {
            $0.image = UIImage(systemName: "plus.circle")?
                .withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.contentMode = .scaleAspectFill
            $0.tintColor = .lightGray
            $0.frame = CGRect(x: self.constraints[0].constant / 2 - (Terminal.convertWidth(value: 50) / 2),
                              y: self.constraints[1].constant / 2 - (Terminal.convertWidth(value: 50) / 2),
                              width: Terminal.convertWidth(value: 50),
                              height: Terminal.convertWidth(value: 50))
        }
        
    }
}
