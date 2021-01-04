//
//  SNSModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SNSModifyView: UIViewController {
    var presenter: SNSModifyPresenterProtocol?
    lazy var firstImage = UIImageView()
    lazy var firstTextFeield = UITextField()
    
    lazy var secondImage = UIImageView()
    lazy var secondTextField = UITextField()
    
    lazy var thirdImage = UIImageView()
    lazy var thirdTextField = UITextField()
    lazy var completeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.view.backgroundColor = .appColor(.terminalBackground)
        [firstImage, secondImage, thirdImage].forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = Terminal.convertWidth(value: 11)
        }
        
        [self.firstTextFeield, self.secondTextField, self.thirdTextField].forEach {
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
        
        self.firstTextFeield.placeholder = "Github ID"
        self.secondTextField.placeholder = "LinkedIn URL"
        self.thirdTextField.placeholder = "Web URL"
        
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    func layout() {
        [firstImage, firstTextFeield, secondImage, secondTextField, thirdImage, thirdTextField, completeButton]
            .forEach { self.view.addSubview($0) }
        
        self.firstImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        self.firstTextFeield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.firstImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.firstImage.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        self.secondImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.firstImage.bottomAnchor, constant: 17).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        self.secondTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.secondImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.secondImage.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        self.thirdImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.secondImage.bottomAnchor, constant: 17).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        self.thirdTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.thirdImage.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.thirdImage.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.thirdTextField.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    @objc func completeModify() {
        let github = firstTextFeield.text ?? ""
        let linkedIn = secondTextField.text ?? ""
        let web = thirdTextField.text ?? ""
        
        self.presenter?.completeModify(github: github, linkedIn: linkedIn, web: web)
    }
}

extension SNSModifyView: SNSModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true, completion: {
                parent?.presenter?.viewDidLoad()
            })
        } else {
            print("message",message)
        }
    }
}
