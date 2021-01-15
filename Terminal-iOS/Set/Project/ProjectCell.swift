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
    lazy var titleLabel = UILabel()
    lazy var contentsLabel = UILabel()
    lazy var title = UITextField()
    lazy var contents = UITextView()
    lazy var sns = ProjectSNSModifyView()
    
    var projectID: Int?
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
    
    func setTag(tag: Int) {
        self.title.tag = tag
        self.contents.tag = tag
        self.sns.firstTextFeield.tag = tag
        self.sns.secondTextField.tag = tag
        self.sns.thirdTextField.tag = tag
    }
    
    func setDelegate(with view: UIViewController) {
        self.title.delegate = (view as! UITextFieldDelegate)
        self.contents.delegate = (view as! UITextViewDelegate)
        self.sns.firstTextFeield.delegate = (view as! UITextFieldDelegate)
        self.sns.secondTextField.delegate = (view as! UITextFieldDelegate)
        self.sns.thirdTextField.delegate = (view as! UITextFieldDelegate)
    }
    
    func setData(data: Project) {
        self.projectID = data.id
        self.title.text = data.title
        self.contents.text = data.contents
        self.sns.firstTextFeield.text = data.snsGithub ?? ""
        self.sns.secondTextField.text = data.snsAppstore ?? ""
        self.sns.thirdTextField.text = data.snsPlaystore ?? ""
    }
    
    func attribute() {
        self.selectionStyle = .none
        
        self.titleLabel.do {
            $0.text = "제목"
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        }
        
        self.contentsLabel.do {
            $0.text = "내용"
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        }
        
        self.remove.do {
            $0.setTitle("ㅡ", for: .normal)
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 15
            $0.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        }
        
        self.title.do {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.placeholder = "프로젝트 타이틀"
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
        
        self.contents.do {
            $0.backgroundColor = .darkGray
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.dynamicFont(size: 13, weight: .regular)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 6)
            $0.delegate = self
        }
    }
    
    func layout() {
        [titleLabel, contentsLabel ,remove, title, contents, sns].forEach { self.contentView.addSubview($0) }
        
        self.remove.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        }
        self.titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        }
        self.contentsLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        }
        self.title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.remove.leadingAnchor, constant: -5).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        self.contents.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.contentsLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 160).isActive = true
        }
        self.sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.contents.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50).isActive = true
        }
    }
    
    @objc func tapButton(_ sender: UIButton) {
        self.delegate?.buttonTapped(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)

        return changedText.count <= 199
    }
}

extension ProjectCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
    }
}
