//
//  UserWithdrawalView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class UserWithdrawalView: UIViewController {
    var presenter: UserWithdrawalPresenterProtocol?
    
    lazy var emailLabel = UILabel()
    lazy var passwordLabel = UILabel()
    lazy var email = UITextField()
    lazy var password = UITextField()
    lazy var refuseButton = UIButton()
    lazy var removeButton = UIButton()
    
    lazy var emailStack = UIStackView()
    lazy var passwordStack = UIStackView()
    lazy var buttonStackView = UIStackView()
    lazy var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appColor(.terminalBackground)
        attribute()
        layout()
    }
    
    private func attribute() {
        self.title = "회원탈퇴"
        [self.email, self.password].forEach {
            $0.do {
                $0.backgroundColor = .appColor(.cellBackground)
                $0.addLeftPadding(padding: 10)
                $0.textColor = .white
                $0.layer.cornerRadius = 10
            }
        }
        
        self.emailLabel.do {
            $0.text = "이메일"
            $0.textColor = .white
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13)
        }
        
        self.passwordLabel.do {
            $0.text = "비밀번호"
            $0.textColor = .white
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 13)
        }
        
        self.refuseButton.do {
            $0.backgroundColor = .darkGray
            $0.layer.cornerRadius = 10
            $0.setTitle("취소", for: .normal)
            $0.addTarget(self, action: #selector(refuse), for: .touchUpInside)
        }
        
        self.removeButton.do {
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 10
            $0.setTitle("삭제", for: .normal)
            $0.addTarget(self, action: #selector(remove), for: .touchUpInside)
        }
        
        self.emailStack.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.addArrangedSubview(self.emailLabel)
            $0.addArrangedSubview(self.email)
        }
        
        self.passwordStack.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.addArrangedSubview(self.passwordLabel)
            $0.addArrangedSubview(self.password)
        }
        
        self.buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .fillEqually
            $0.addArrangedSubview(self.refuseButton)
            $0.addArrangedSubview(self.removeButton)
        }
        
        self.stackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fillEqually
            $0.addArrangedSubview(self.emailStack)
            $0.addArrangedSubview(self.passwordStack)
        }
    }
    
    private func layout() {
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.buttonStackView)
        
        self.stackView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 180).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }
        self.buttonStackView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }
    }
    
    @objc func refuse() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func remove() {
        let emailText = self.email.text!
        let passwordText = self.password.text!
        
        presenter?.userWithdrawal(email: emailText, password: passwordText)
    }
}

extension UserWithdrawalView: UserWithdrawalViewProtocol {
    func resultUserWithdrawal(message: String?) {
        if let message = message {
            self.showToast(controller: self, message: message, seconds: 1, completion: nil)
        } else {
            self.showToast(controller: self, message: "회원이 탈퇴되었습니다.", seconds: 1) {
                self.presenter?.goToIntroView()
            }
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}
