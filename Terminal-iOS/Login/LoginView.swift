//
//  LoginView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum state: String {
    case emailInput
    case pwdInput
    case nickname
}

class IntroView: UIViewController {
    
    var closeButton = UIButton()
    var nextButton = UIButton()
    var guideLabel = UILabel()
    var emailTextfield = UITextField()
    var cancelButton = UIButton()
    var state: state?
    var rightBarButton: UIBarButtonItem?
    var leftBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        rightBarButton = UIBarButtonItem(customView: nextButton)
        leftBarButton = UIBarButtonItem(customView: closeButton)
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.testColor)
            $0.navigationItem.rightBarButtonItem = rightBarButton
            $0.navigationItem.leftBarButtonItem = leftBarButton
            
            $0.navigationController?.navigationBar.shadowImage = UIImage()
            $0.navigationController?.navigationBar.isTranslucent = false
            $0.navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
            
            $0.view.backgroundColor = UIColor.systemBackground
        }
        emailTextfield.do {
            $0.font = UIFont.boldSystemFont(ofSize: 18)
        }
        closeButton.do {
            $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            $0.addTarget(self, action: #selector(didClickedCloseButon), for: .touchUpInside)
        }
        nextButton.do {
            $0.setTitle("다음", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.addTarget(self, action: #selector(didClickedNextButton), for: .touchUpInside)
        }
        guideLabel.do {
            $0.numberOfLines = 0
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        cancelButton.do {
            $0.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
            $0.addTarget(self, action: #selector(didClickedCancelButton), for: .touchUpInside)
        }
    }
    
    func layout() {
        [emailTextfield, closeButton, nextButton, guideLabel, cancelButton].forEach { view.addSubview($0) }
        
        emailTextfield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (40/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * ( 235 / 375 )).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * ( 32 / 667 )).isActive = true
        }
        closeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: (18/667) * UIScreen.main.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: (18/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (18/375) * UIScreen.main.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (18/375) * UIScreen.main.bounds.width).isActive = true
        }
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: emailTextfield.topAnchor, constant: -(20/667) * UIScreen.main.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (33/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (137/375) * UIScreen.main.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (93/667) * UIScreen.main.bounds.height).isActive = true
        }
        cancelButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: emailTextfield.trailingAnchor,constant: 10).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    func setting() {
    }
    @objc func keyboardWillHide(notification: Notification) {
        emailTextfield.becomeFirstResponder()
    }
    @objc func didClickedCloseButon() {
        dismiss(animated: true)
    }
    @objc func didClickedNextButton() {
        
        let view = IntroView()
        switch state {
        case .emailInput:
            view.guideLabel.text = "사용하실 비밀번호를\n설정해 주세요"
            view.emailTextfield.placeholder = "비밀번호"
            view.state = .pwdInput
            self.emailTextfield.endEditing(true)
        case .pwdInput:
            view.guideLabel.text = "가입을 위해\n닉네임을 입력해 주세요"
            view.emailTextfield.placeholder = "추천 닉네임"
            view.state = .nickname
            self.emailTextfield.endEditing(true)
        case .nickname:
            dismiss(animated: true)
        case .none:
            print("none")
        case .some(_):
            print("some")
        }
        
        navigationController?.pushViewController(view, animated: true) {
//            view.emailTextfield.becomeFirstResponder()
        }
    }
    
    @objc func didClickedCancelButton() {
        switch state {
        case .emailInput:
            emailTextfield.text = ""
        case .pwdInput:
            emailTextfield.text = ""
        case .nickname:
            emailTextfield.text = ""
        case .none:
            print("none")
        case .some(_):
            print("some")
        }
    }
}
