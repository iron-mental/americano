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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.view.backgroundColor = .appColor(.terminalBackground)
        self.emailLabel.do {
            $0.text = "Email"
            $0.textColor = .white
            $0.font = UIFont.notosansMedium(size: 14)
        }
        self.emailTextField.do {
            $0.text = email ?? ""
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.addLeftPadding()
            $0.font = UIFont.notosansMedium(size: 18)
        }
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    private func layout() {
        self.view.addSubview(emailLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(completeButton)
        
        self.emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        }
        self.emailTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    @objc func completeModify() {
        let email = self.emailTextField.text ?? ""
        presenter?.completeModify(email: email)
    }
}

extension EmailModifyView: EmailModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true, completion: {
                parent?.showToast(controller: parent!, message: "Email 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            })
        } else {
            self.showToast(controller: self, message: message, seconds: 1)
        }
    }
}
