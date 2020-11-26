//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/06.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileDetailView: UIViewController {
    // MARK: Init Property
    var presenter: ProfileDetailPresenterProtocol?
    let scrollView = UIScrollView()
    let profile = ProfileView()
    
    let carrer      = CarrerView()
    let project     = ProjectView()
    let sns         = SNSView()
    let email       = EmailView()
    let location    = LocationView()
    
    let projectStack = UIStackView()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        print("viewdidload")
        presenter?.viewDidLoad(id: 1)
    }
    
    // MARK: Set Attribute
    func attribute() {
        let modifyBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "modifiy"), style: .plain, target: self, action: #selector(pushProfileModify))
        [carrer, project, sns, email, location].forEach {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
        }
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationItem.rightBarButtonItem = modifyBtn
        }
        profile.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.profileImage.image = #imageLiteral(resourceName: "leehi")
        }
    }
    
    // MARK: Set Layout
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
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: profile.heightAnchor).isActive = true
        }
        carrer.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: carrer.heightAnchor).isActive = true
        }
        project.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: carrer.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: project.heightAnchor).isActive = true
        }
        sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: project.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: sns.heightAnchor).isActive = true
        }
        email.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: sns.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: email.heightAnchor).isActive = true
        }
        location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    }
    
    @objc func pushProfileModify() {
        let view = ProfileModifyView()
        view.nameModify.text = self.profile.name.text
        view.descripModify.text = self.profile.descript.text
        navigationController?.pushViewController(view, animated: false)
    }
}

extension ProfileDetailView: ProfileDetailViewProtocol {
    
}
