//
//  ProjectView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProjectView: UIView {
    
    init(title: String, contents: String ,frame: CGRect) {
        super.init(frame: frame)
        let projectTitle = UILabel().then {
            $0.text = title
            $0.textColor = .white
            $0.dynamicFont(fontSize: 20, weight: .bold)
        }
        let projectContents = UILabel().then {
            $0.text = contents
            $0.numberOfLines = 0
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(fontSize: 16, weight: .regular)
        }
        
        addSubview(projectTitle)
        addSubview(projectContents)
        
        projectTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        projectContents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectTitle.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
