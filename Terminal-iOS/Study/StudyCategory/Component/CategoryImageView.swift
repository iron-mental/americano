//
//  CategoryImageView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/22.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class CategoryImageView: UIView {

    lazy var title = UILabel()
    lazy var image = UIImageView()
    
    init() {
        super.init(frame: .zero)
        attribuete()
        layout()
    }
    
    private func attribuete() {
        self.image.do {
            $0.layer.cornerRadius = 10
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
            $0.alpha = 0.2
        }
        self.title.do {
            $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = UIFont(name: "NotoSansKR-Bold", size: 25)
        }
    }
    
    private func layout() {
        self.addSubview(self.image)
        self.addSubview(self.title)
        
        self.image.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        }
        
        self.title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.image.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.image.centerXAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.image.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.image.trailingAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
