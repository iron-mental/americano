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
    let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.appColor(.terminalBackground)
    }
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
    
    let projectStack = UIStackView()
    
    let snsBackground = UIView().then {
        $0.backgroundColor = .cyan
    }
    let snsLabel = UILabel()
    
    let emailBackground = UIView().then {
        $0.backgroundColor = .brown
    }
    let emailLabel = UILabel()
    let email = UILabel()
    
    let locationBackground = UIView().then {
        $0.backgroundColor = .blue
    }
    let locationLabel = UILabel()
    let location = UILabel()
    
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
//        projectStack.do {
//            $0.axis = .vertical
//            $0.alignment = .leading
//            $0.distribution = .fillProportionally
//            $0.backgroundColor = .blue
//            $0.addArrangedSubview(projectLabel)
//            $0.addArrangedSubview(projectTitle)
//            $0.addArrangedSubview(projectDescript)
//        }
//        
        snsLabel.do {
            $0.text = "SNS"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 12, weight: .regular)
        }
        emailLabel.do {
            $0.text = "Email"
            $0.textColor = .black
        }
        email.do {
            $0.text = "jerry@gmail.com"
            $0.textColor = .black
        }
        locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .black
        }
        location.do {
            $0.text = "서울 마포구 주민입니다. 서울 모든 곳 가능합니다."
            $0.textColor = .black
        }

    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(profile)
        backgroundView.addSubview(carrer)
        backgroundView.addSubview(project)
        
        // 스크롤뷰 오토레이아웃
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        }
        profile.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: profile.heightAnchor).isActive = true
        }
        carrer.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profile.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: carrer.heightAnchor).isActive = true
        }
        project.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: carrer.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: project.heightAnchor).isActive = true
        }
    }
}

extension ProfileModifyView: ProfileModifyViewProtocol {
    
}
