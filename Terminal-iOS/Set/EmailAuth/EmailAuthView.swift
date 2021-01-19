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
    
    let emailAuth = EmailAlertMessageView(message: "이메일 인증하시겠습니까?\n\n 회원님의 이메일로 인증요청 됩니다.")

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        self.emailAuth.alertMessageLabel.do {
            $0.textColor = UIColor.appColor(.alertTextcolor)
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.font = UIFont.monospacedSystemFont(ofSize: $0.font.pointSize, weight: UIFont.Weight.regular)
        }
            
        let button = self.emailAuth as AlertBaseUIView
        button.completeButton.addTarget(self, action: #selector(completeClick), for: .touchUpInside)
        button.dismissButton.addTarget(self, action: #selector(dismissClick), for: .touchUpInside)
    }
    
    private func layout() {
        self.view.addSubview(emailAuth)
        
        self.emailAuth.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 300).isActive = true
            $0.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
        }
    }
    
    @objc func dismissClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func completeClick() {
        presenter?.emailAuthRequest()
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
