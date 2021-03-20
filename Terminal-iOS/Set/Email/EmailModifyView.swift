//
//  EmailModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class EmailModifyView: UIViewController {
    var presenter: EmailModifyPresenterProtocol?
    
    var email: String?
    lazy var emailLabel = UILabel()
    lazy var emailTextField = UITextField()
    lazy var completeButton = UIButton()
    var accessoryCompleteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.do {
            $0.hideKeyboardWhenTappedAround()
            $0.view.backgroundColor = .appColor(.terminalBackground)
            $0.title = "이메일 수정"
        }
        self.emailLabel.do {
            $0.text = "Email"
            $0.textColor = .white
            $0.font = UIFont.notosansMedium(size: 14)
        }
        self.emailTextField.do {
            $0.text = email ?? ""
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.addLeftPadding(padding: 10)
            $0.font = UIFont.notosansMedium(size: 18)
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
            $0.inputAccessoryView = accessoryCompleteButton
        }
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
        self.accessoryCompleteButton.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    private func layout() {
        self.view.addSubview(emailLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(completeButton)
        
        self.emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        }
        self.emailTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func completeModify() {
        let email = self.emailTextField.text ?? ""
        // 공백체크
        if email.whitespaceCheck() {
            self.showToast(controller: self, message: "공백은 포함되지 않습니다.", seconds: 0.5)
        } else {
            showLoading()
            presenter?.completeModify(email: email)
        }
    }
}

extension EmailModifyView: EmailModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true, completion: {
                parent?.showToast(controller: parent!, message: "Email 수정 완료", seconds: 1, completion: nil)
                parent?.presenter?.viewDidLoad()
            })
            
            let rootParent = self.navigationController?.viewControllers[0] as? SetView
            rootParent?.presenter?.viewDidLoad()
        } else {
            hideLoading()
            self.emailTextField.warningEffect()
            self.showToast(controller: self, message: message, seconds: 1, completion: nil)
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}
