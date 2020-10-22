//
//  LoginView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    var closeButton = UIButton()
    var emailTextfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.testColor)
        }
        emailTextfield.do {
            $0.placeholder = "이메일 입력하세요"
        }
        closeButton.do {
            $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
            $0.addTarget(self, action: #selector(didClickedCloseButon), for: .touchUpInside)
        }
    }
    
    func layout() {
        view.addSubview(emailTextfield)
        view.addSubview(closeButton)
        
        emailTextfield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * ( 285 / 375 )).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * ( 32 / 667 )).isActive = true
        }
        closeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: (18/667) * UIScreen.main.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: (18/375) * UIScreen.main.bounds.width).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (18/375) * UIScreen.main.bounds.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (18/375) * UIScreen.main.bounds.width).isActive = true
        }
    }
    
    @objc func didClickedCloseButon() {
        dismiss(animated: true)
    }
}
