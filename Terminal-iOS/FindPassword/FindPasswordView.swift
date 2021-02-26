//
//  FindPasswordView.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import Then

final class FindPasswordView: UIViewController {
    var presenter: FindPasswordPresenterProtocol?
    
    let backButton = UIButton()
    let descript = UILabel()
    let emailTextField = UITextField()
    let resetButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        self.emailTextField.becomeFirstResponder()
    }
    
    private func attribute() {
        self.do {
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        self.backButton.do {
            $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            $0.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
        self.descript.do {
            $0.text = "터미널에서 가입했던 이메일을 입력해주세요.\n비밀번호 재설정 메일을 보내드립니다."
            $0.font = .notosansMedium(size: 15)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        self.emailTextField.do {
            $0.placeholder = "이메일 입력"
            $0.attributedPlaceholder = NSAttributedString(string: "이메일 입력",
                                                          attributes: [
                                                            .foregroundColor: UIColor.lightGray,
                                                            .font: UIFont.notosansMedium(size: 15)])
            $0.backgroundColor = .appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
            $0.addLeftPadding(padding: 10)
        }
        self.resetButton.do {
            $0.setTitle("비밀번호 재설정", for: .normal)
            $0.titleLabel?.font = .notosansMedium(size: 15)
            $0.backgroundColor = .appColor(.mainColor)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(reset), for: .touchUpInside)
        }
    }
    
    private func layout() {
        [backButton, descript, emailTextField, resetButton].forEach { self.view.addSubview($0) }
        
        self.backButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                    constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 18)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 18)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 18)).isActive = true
        }
        self.descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                    constant: Terminal.convertHeight(value: 100)).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
        self.emailTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.descript.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: self.descript.intrinsicContentSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        self.resetButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: self.descript.intrinsicContentSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func reset() {
        guard let email = self.emailTextField.text else { return }
        self.presenter?.resetRequest(email: email)
    }
}

extension FindPasswordView: FindPasswordViewProtocol {
    func showResult(result: Bool, message: String?) {
        if result {
            let view = FindPasswordResultView()
            self.navigationController?.pushViewController(view, animated: true)
        } else {
            guard let message = message else {
                self.showToast(controller: self, message: "나중에 다시 시도해 주세요.", seconds: 1)
                return
            }
            self.showToast(controller: self, message: message, seconds: 1)
        }
    }
}
