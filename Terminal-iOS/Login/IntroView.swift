//
//  LoginView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum IntroViewState: String {
    case emailInput
    case pwdInput
    case nickname
}

class IntroView: UIViewController {
    
    var leftButton = UIButton()
    var rightbutton = UIButton()
    var guideLabel = UILabel()
    var emailTextfield = UITextField()
    var cancelButton = UIButton()
    var state: IntroViewState?
    var rightBarButton: UIBarButtonItem?
    var leftBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        attribute()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextfield.becomeFirstResponder()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func setting() {
        switch state {
        case .emailInput:
            self.guideLabel.text = "이메일을\n입력해 주세요"
            self.emailTextfield.placeholder = "abc1234@terminal.com"
            self.state = .emailInput
            self.leftButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            self.rightbutton.setTitle("다음", for: .normal)
            break
        case .pwdInput:
            self.guideLabel.text = "사용하실 비밀번호를\n설정해 주세요"
            self.emailTextfield.placeholder = "비밀번호"
            self.state = .pwdInput
            self.leftButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            self.rightbutton.setTitle("다음", for: .normal)
            break
        case .nickname:
            self.guideLabel.text = "가입을 위해\n닉네임을 입력해 주세요"
            self.emailTextfield.placeholder = "추천 닉네임"
            self.state = .nickname
            self.leftButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            self.rightbutton.setTitle("완료", for: .normal)
            break
        case .none:
            print("none")
            break
        case .some(_):
            print("some")
            break
        }
    }
    
    func attribute() {
        rightBarButton = UIBarButtonItem(customView: rightbutton)
        leftBarButton = UIBarButtonItem(customView: leftButton)
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
        leftButton.do {
            $0.addTarget(self, action: #selector(didClickedBackButon), for: .touchUpInside)
        }
        rightbutton.do {
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
        [emailTextfield, leftButton, rightbutton, guideLabel, cancelButton].forEach { view.addSubview($0) }
        
        emailTextfield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (40/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * ( 235 / 375 )).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * ( 32 / 667 )).isActive = true
        }
        leftButton.do {
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
    @objc func didClickedBackButon() {
        self.emailTextfield.endEditing(true)
        switch state {
        case .emailInput:
            dismiss(animated: true)
            break
        case .pwdInput:
            navigationController?.popViewController(animated: true)
            
            break
        case .nickname:
            navigationController?.popViewController(animated: true)
            break
        default:
            print("none")
        }
        self.emailTextfield.endEditing(true)
    }
    
    @objc func didClickedNextButton() {
        let view = IntroView()
        
        switch state {
        case .emailInput:
            view.state = .pwdInput
            self.emailTextfield.endEditing(true)
            break
        case .pwdInput:
            view.state = .nickname
            self.emailTextfield.endEditing(true)
            break
        case .nickname:
            self.state = .nickname
            dismiss(animated: true)
            break
        default:
            print("none")
        }
        
        navigationController?.pushViewController(view, animated: true) {
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
