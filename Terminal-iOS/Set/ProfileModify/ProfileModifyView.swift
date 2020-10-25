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
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .red
    }
    let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.appColor(.terminalBackground)
    }
    let profile = ProfileView().then {
        $0.backgroundColor = .blue
        $0.profileImage.image = #imageLiteral(resourceName: "leehi")
    }
    let profileImage = UIImageView()
    let name = UILabel()
    let descript = UILabel()
    
    let careerStack = UIStackView()
    let careerLabel = UILabel()
    let careerTitle = UILabel()
    let careerDescript = UILabel()
    let careerDescriptBackground = UIView()
    
    let projectStack = UIStackView()
    let projectLabel = UILabel()
    let projectTitle = UILabel()
    let projectDescript = UILabel()
    
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
        profileImage.do {
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = UIScreen.main.bounds.height * 0.15
            $0.frame.size.height = UIScreen.main.bounds.height * 0.15
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
        name.do {
            $0.text = "이하이"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.dynamicFont(fontSize: 20, weight: .semibold)
        }
        descript.do {
            $0.text = "iOS를 공부하는 중입니다. 잘 부탁드립니다."
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.dynamicFont(fontSize: 16, weight: .regular)
        }
        careerStack.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .fillProportionally
            $0.backgroundColor = .red
            $0.addArrangedSubview(careerLabel)
            $0.addArrangedSubview(careerTitle)
            $0.addArrangedSubview(careerDescript)
        }
        careerLabel.do {
            $0.text = "경력"
            $0.textColor = .black
        }
        careerTitle.do {
            $0.text = "OO대학교 4학년 재학중"
            $0.textColor = .black
            $0.dynamicFont(fontSize: 20, weight: .bold)
        }
        careerDescript.do {
            $0.text = "경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다.경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다."
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.dynamicFont(fontSize: 16, weight: .regular)
        }
        projectStack.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .fillProportionally
            $0.backgroundColor = .blue
            $0.addArrangedSubview(projectLabel)
            $0.addArrangedSubview(projectTitle)
            $0.addArrangedSubview(projectDescript)
        }
        projectLabel.do {
            $0.text = "프로젝트"
            $0.textColor = .black
        }
        projectTitle.do {
            $0.text = "Terminal"
            $0.textColor = .black
            $0.dynamicFont(fontSize: 20, weight: .bold)
        }
        projectDescript.do {
            $0.text = "MANNA는 어떠 어떠한 프로젝트이며 이러 이러 합니다. 저러 저러한 사람들이 쉽게 이러 이러하고 요로요로 어쩌고 저쩌고 하여 만들어진 프로젝트입니다. 이러이러한 걸 맡았고 어쩌고 저쩌고 하였습니다. 아래 github 링크에서 자세한 내용 확인하실 수 있습니다."
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.dynamicFont(fontSize: 16, weight: .regular)
        }
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
//        backgroundView.addSubview(profileImage)
//        backgroundView.addSubview(name)
//        backgroundView.addSubview(descript)
        
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
            $0.heightAnchor.constraint(equalToConstant: 250).isActive = true
        }
//        profileImage.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 15).isActive = true
//            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
//            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
//        }
//        name.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
//            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
//        }
//        descript.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 7).isActive = true
//            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
//        }
    }
}

extension ProfileModifyView: ProfileModifyViewProtocol {
    
}
