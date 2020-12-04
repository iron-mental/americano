//
//  ProjectCell.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol CellSubclassDelegate: class {
    func buttonTapped(cell: ProjectCell)
}

class ProjectCell: UITableViewCell {
    static let projectCellID = "ProjectCellID"
    lazy var remove = UIButton()
    lazy var title = UITextField()
    lazy var contents = UITextView()
    lazy var sns = ProjectSNSView()
    
    var delegate: CellSubclassDelegate?
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    func setData(data: Project) {
        self.title.text = data.title
        self.contents.text = data.contents
        self.sns.firstTextFeield.text = data.snsGithub
        self.sns.secondTextField.text = data.snsAppstore
        self.sns.thirdTextField.text = data.snsPlaystore
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
        self.contentView.addSubview(sns)
        
        remove.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        }
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.remove.leadingAnchor, constant: -5).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        contents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 160).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.contents.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//            $0.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    @objc func tapButton(_ sender: UIButton) {
        self.delegate?.buttonTapped(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
