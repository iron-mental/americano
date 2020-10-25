//
//  ProjectView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProjectView: UIView {
    let projectLabel = UILabel()
    let projectTitle = UILabel()
    let projectDescript = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attibute()
        layout()
    }
    
    func attibute() {
        projectLabel.do {
            $0.text = "프로젝트"
            $0.textColor = .black
        }
        projectTitle.do {
            $0.text = "Terminal"
            $0.textColor = .black
            $0.dynamicFont(fontSize: 20, weight: .bold)
        }
        projectDescript.do {
            $0.text = "MANNA는 어떠 어떠한 프로젝트이며 이러 이러 합니다. 저러 저러한 사람들이 쉽게 이러 이러하고 요로요로 어쩌고 저쩌고 하여 만들어진 프로젝트입니다. 이러이러한 걸 맡았고 어쩌고 저쩌고 하였습니다. 아래 github 링크에서 자세한 내용 확인하실 수 있습니다."
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.dynamicFont(fontSize: 16, weight: .regular)
        }
    }
    
    func layout() {
        addSubview(projectLabel)
        addSubview(projectTitle)
        addSubview(projectDescript)
        
        projectLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        projectTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.projectLabel.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        projectDescript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.projectTitle.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
