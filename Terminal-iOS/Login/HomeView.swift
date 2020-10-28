//
//  HomeView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    var loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        loginButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func layout() {
        view.addSubview(loginButton)
        
//        loginButton.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: convertHeigt(value: 20)).isActive = true
//            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -convertWidth(value: 25)).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: convertHeigt(value: 19)).isActive = true
//            $0.widthAnchor.constraint(equalToConstant: convertWidth(value: 42)).isActive = true
//        }
    }
    
}
