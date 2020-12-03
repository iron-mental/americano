//
//  ProjectCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    static let projectCellID = "ProjectCellID"
    
    let title = UITextField()
    let contents = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        self.contentView.addSubview(title)
        self.contentView.addSubview(contents)
        
        title.do {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.placeholder = "프로젝트 타이틀"
        }
        
        contents.do {
            $0.backgroundColor = .darkGray
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.dynamicFont(size: 13, weight: .regular)
            $0.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
    
    func layout() {
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        contents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 160).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
