//
//  HomeView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class HomeView: UIViewController {
    var loginButton = UIButton()
    var signUpButton = UIButton()
    var findPWButton = ResizableButton()
    var mainImage = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.navigationController?.navigationBar.shadowImage = UIImage()
            $0.navigationController?.navigationBar.isTranslucent = false
            $0.navigationController?.navigationBar.backgroundColor = .white
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        loginButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.titleLabel?.dynamicFont(fontSize: 16, weight: .bold)
            $0.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        }
        signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.titleLabel?.dynamicFont(fontSize: 18, weight: .bold)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.addTarget(self, action: #selector(goSignUp), for: .touchUpInside)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        findPWButton.do {
            $0.setTitle("로그인에 문제가 있으신가요?", for: .normal)
            $0.setTitleColor(.appColor(.mainColor), for: .normal)
            $0.titleLabel?.dynamicFont(fontSize: 12, weight: .medium)
            $0.backgroundColor = .darkGray
            $0.addTarget(self, action: #selector(goFindPassword), for: .touchUpInside)
        }
        mainImage.do {
            $0.image = UIImage(systemName: "terminal.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.tintColor = .white
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func layout() {
        [loginButton, signUpButton, findPWButton, mainImage].forEach { view.addSubview($0) }
        
        loginButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                    constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                         constant: -10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        signUpButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 50)).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.findPWButton.topAnchor,
                                       constant: Terminal.convertHeight(value: -5)).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        findPWButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 40)).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                       constant: Terminal.convertHeight(value: -5)).isActive = true
        }
        mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 130).isActive = true
        }
    }
    
    @objc func goFindPassword() {
        
    }
    
    @objc func goLogin() {
        let view = IntroWireFrame.createIntroModule(beginState: .join, introState: .emailInput)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func goSignUp() {
        let view = IntroWireFrame.createIntroModule(beginState: .signUp, introState: .emailInput)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
