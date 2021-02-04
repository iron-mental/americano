//
//  ProjectListView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/18.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ProjectListView: UIView {
    
    let modify = UIButton()
    let projectStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    func attribute() {
        self.modify.do {
            $0.setTitle("수정", for: .normal)
            $0.setTitleColor(.appColor(.mainColor), for: .normal)
        }
        self.projectStack.do {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 5
        }
    }
    
    func layout() {
        self.addSubview(modify)
        self.addSubview(projectStack)
        
        self.modify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        self.projectStack.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.modify.bottomAnchor, constant: -20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.modify.leadingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
