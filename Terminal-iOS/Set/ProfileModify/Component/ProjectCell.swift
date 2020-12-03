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
    var tapped: (() -> ())?
    let remove = UIButton()
    let title = UITextField()
    let contents = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func attribute() {
        remove.do {
            $0.setTitle("-", for: .normal)
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 15
            $0.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        }
        
        title.do {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.placeholder = "프로젝트 타이틀"
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
        
        contents.do {
            $0.backgroundColor = .darkGray
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.dynamicFont(size: 13, weight: .regular)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 6)
        }
    }
    
    func layout() {
        self.contentView.addSubview(remove)
        self.contentView.addSubview(title)
        self.contentView.addSubview(contents)
        
        remove.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        }
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.remove.leadingAnchor, constant: -5).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        contents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 160).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        }
    }
    
    
    @objc func tapButton(_ sender: UIButton) {
        tapped?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
