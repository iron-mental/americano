//
//  AddNoticeView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class AddNoticeView: UIViewController {
    var presenter: AddNoticePresenterProtocol?
    var studyID: Int?
    
    var pinButton = UIButton()
    var titleTextField = UITextField()
    var contentTextField = UITextView()
    var completeButton = UIButton()
    
    override func viewDidLoad() {
        attribute()
        layout()
    }
    
    func attribute() {
        pinButton.do {
            $0.backgroundColor = UIColor.appColor(.pinnedNoticeColor)
            $0.setTitle("필독", for: .normal)
            $0.layer.cornerRadius = 3
            $0.layer.masksToBounds = true
        }
        titleTextField.do {
            $0.placeholder = "제목을 입력하세요"
            $0.textColor = .white
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
        }
        contentTextField.do {
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.textColor = .white
        }
        completeButton.do {
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.setTitle("완료", for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
    }
    
    func layout() {
        [pinButton, titleTextField, contentTextField, completeButton].forEach { view.addSubview($0) }
        
        pinButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeigt(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertHeigt(value: 13)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 41)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        titleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: pinButton.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: pinButton.trailingAnchor, constant: Terminal.convertWidth(value: 10)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Terminal.convertHeigt(value: -13)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 20)).isActive = true
        }
        contentTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Terminal.convertHeigt(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertHeigt(value: 13)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertHeigt(value: -13)).isActive = true
            $0.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: Terminal.convertHeigt(value: -9)).isActive = true
        }
        completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -1).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 335)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 45)).isActive = true
        }
    }
}

extension AddNoticeView: AddNoticeViewProtocol {
    func showNewNotice() {
//        <#code#>
    }
}
