//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/06.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyView: UIViewController {
    
    var presenter: ProfileModifyPresenterProtocol?
    let scrollView = UIScrollView()
    let profile = ProfileView().then {
        $0.backgroundColor = .blue
        $0.profileImage.image = #imageLiteral(resourceName: "leehi")
    }
    let carrer = CarrerView().then {
        $0.backgroundColor = .cyan
    }
    let project = ProjectView().then {
        $0.backgroundColor = .red
    }
    let sns = SNSView().then {
        $0.backgroundColor = .blue
    }
    let email = EmailView().then {
        $0.backgroundColor = .yellow
    }
    let location = LocationView().then {
        $0.backgroundColor = .blue
    }
    let projectStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        let modifyBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "modifiy"), style: .plain, target: nil, action: nil)
        
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationItem.rightBarButtonItem = modifyBtn
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        [profile, carrer, project, sns, email, location].forEach { scrollView.addSubview($0) }
        
        // 스크롤뷰 오토레이아웃
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        profile.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * (240 / 667)).isActive = true
        }
        carrer.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalTo: carrer.heightAnchor).isActive = true
        }
        project.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: carrer.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalTo: project.heightAnchor).isActive = true
        }
        sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: project.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalTo: sns.heightAnchor).isActive = true
        }
        email.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: sns.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalTo: email.heightAnchor).isActive = true
        }
        location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    }
}

extension ProfileModifyView: ProfileModifyViewProtocol {
    
}
