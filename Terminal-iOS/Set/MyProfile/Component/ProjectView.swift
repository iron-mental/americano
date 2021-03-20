//
//  ProjectView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class ProjectView: UIView {
    var snsList: [String: String] = [:]
    var sns = ProjectSNSView()
    var projectTitle = UILabel()
    var projectContents = UILabel()
    
    init(title: String,
         contents: String,
         snsGithub: String,
         snsAppStore: String,
         snsPlayStore: String,
         frame: CGRect
    ) {
        super.init(frame: frame)
        projectTitle = UILabel().then {
            $0.text = title
            $0.textColor = .white
            $0.dynamicFont(fontSize: 18, weight: .bold)
        }
        
        projectContents = UILabel().then {
            $0.text = contents
            $0.lineBreakMode = .byCharWrapping
            $0.numberOfLines = 0
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
        
        self.addSubview(projectTitle)
        self.addSubview(projectContents)
        self.addSubview(sns)
        
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
        }
        sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectContents.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }
        
        self.checkSNSList(snsGithub: snsGithub, snsAppStore: snsAppStore, snsPlayStore: snsPlayStore)
        self.sns.addstack(snsList: self.snsList)
    }
    
    private func checkSNSList(snsGithub: String, snsAppStore: String, snsPlayStore: String) {
        self.snsList.updateValue(snsGithub, forKey: SNSState.github.rawValue)
        self.snsList.updateValue(snsAppStore, forKey: SNSState.appStore.rawValue)
        self.snsList.updateValue(snsPlayStore, forKey: SNSState.playStore.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
