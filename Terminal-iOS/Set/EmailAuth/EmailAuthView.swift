//
//  EmailAuthView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class EmailAuthView: UIViewController {
    var presenter: EmailAuthPresenterProtocol?
    
    let content = UILabel()
    let buttonStack = UIStackView()
    let refuseButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    let acceptButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.view.backgroundColor = .appColor(.terminalBackground)
        self.content.do {
            $0.text = "이메일을 인증 하시겠습니까?\n 회원님의 이메일은 swdoris@gamill.cim입니다.\n 이메일로 인증요청이 "
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        self.buttonStack.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .fillEqually
            $0.addArrangedSubview(self.refuseButton)
            $0.addArrangedSubview(self.acceptButton)
        }
        
        self.refuseButton.do {
            $0.backgroundColor = .red
            $0.setTitle("취소", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(refuse), for: .touchUpInside)
        }
        
        self.acceptButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(accept), for: .touchUpInside)
        }
    }
    
    private func layout() {
        self.view.addSubview(self.content)
        self.view.addSubview(self.buttonStack)
        
        self.content.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
        self.buttonStack.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.content.bottomAnchor, constant: 30).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 220).isActive = true
        }
    }
    
    @objc func accept() {
        presenter?.emailAuthRequest()
    }
    
    @objc func refuse() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EmailAuthView: EmailAuthViewProtocol {
    func emailAuthResponse(result: Bool, message: String) {
        if result {
            guard let view = self.presentingViewController else { return }
            self.dismiss(animated: true) {
                view.showToast(controller: view, message: "이메일로 인증이 전송되었습니다.", seconds: 2)
            }
        }
    }
}
