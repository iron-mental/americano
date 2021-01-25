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
    var mainImage = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.navigationController?.navigationBar.shadowImage = UIImage()
            $0.navigationController?.navigationBar.isTranslucent = false
            $0.navigationController?.navigationBar.backgroundColor = UIColor.white
        }
        loginButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        }
        signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.addTarget(self, action: #selector(goSignUp), for: .touchUpInside)
            $0.layer.cornerRadius = 10
        }
        mainImage.do {
            $0.image = UIImage(named: "homeImage")
        }
    }
    
    func layout() {
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        view.addSubview(mainImage)
        
        loginButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        signUpButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }
        mainImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 55).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 242).isActive = true
        }
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
