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
        $0.backgroundColor = .white
    }
    let profileAreaView = UIView().then {
        $0.backgroundColor = .yellow
    }
    let careerAreaView = UIView().then {
        $0.backgroundColor = .blue
    }
    let projectAreaView = UIView().then {
        $0.backgroundColor = .cyan
    }
    let snsAreaView = UIView().then {
        $0.backgroundColor = .darkGray
    }
    let emailAreaView = UIView().then {
        $0.backgroundColor = .green
    }
    let locationAreaView = UIView().then {
        $0.backgroundColor = .red
    }
    let profileImage = UIImageView()
    let name = UILabel()
    let descript = UILabel()
    
    let careerLabel = UILabel()
    let careerTitle = UILabel()
    let careerDescript = UILabel()
    
    let projectLabel = UILabel()
    let projectTitle = UILabel()
    let projectDescript = UILabel()
    
    let snsLabel = UILabel()
    
    let emailLabel = UILabel()
    let email = UILabel()
    
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
            $0.textColor = .black
            $0.textAlignment = .center
            $0.dynamicFont(fontSize: 20, weight: .bold)
        }
        descript.do {
            $0.text = "iOS를 공부하는 중입니다. 잘 부탁드립니다."
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.dynamicFont(fontSize: 16, weight: .regular)
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
            $0.text = "경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다."
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.dynamicFont(fontSize: 16, weight: .regular)
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
            $0.textColor = .black
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
        
        backgroundView.do {
            $0.addSubview(profileAreaView)
            $0.addSubview(careerAreaView)
            $0.addSubview(projectAreaView)
            $0.addSubview(snsAreaView)
            $0.addSubview(emailAreaView)
            $0.addSubview(locationAreaView)
        }
        profileAreaView.do {
            $0.addSubview(profileImage)
            $0.addSubview(name)
            $0.addSubview(descript)
        }
        careerAreaView.do {
            $0.addSubview(careerLabel)
            $0.addSubview(careerTitle)
            $0.addSubview(careerDescript)
        }
        projectAreaView.do {
            $0.addSubview(projectLabel)
            $0.addSubview(projectTitle)
            $0.addSubview(projectDescript)
        }
        snsAreaView.do {
            $0.addSubview(snsLabel)
        }
        emailAreaView.do {
            $0.addSubview(emailLabel)
            $0.addSubview(email)
        }
        locationAreaView.do {
            $0.addSubview(locationLabel)
            $0.addSubview(location)
        }
        
        // 스크롤뷰 오토레이아웃
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        // 전체영역의 뷰
        backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 1.31).isActive = true
        }
        
        // 프로필 영역
        profileAreaView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.355).isActive = true
        }
        
        // 경력 영역
        careerAreaView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileAreaView.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.218).isActive = true
        }
        
        // 프로젝트 영역
        projectAreaView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerAreaView.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.368).isActive = true
        }
        
        // SNS 영역
        snsAreaView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectAreaView.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.098).isActive = true
        }
        
        // 이메일 영역
        emailAreaView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsAreaView.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.091).isActive = true
        }
        
        // 지역 영역
        locationAreaView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailAreaView.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        }
        
        // 프로필 요소
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileAreaView.topAnchor,
                                    constant: UIScreen.main.bounds.height * 0.02).isActive = true
            $0.centerXAnchor.constraint(equalTo: profileAreaView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
        }
        name.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: profileAreaView.centerXAnchor).isActive = true
        }
        descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: profileAreaView.centerXAnchor).isActive = true
        }
        
        // 경력 요소
        careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerAreaView.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: careerAreaView.leadingAnchor, constant: 24).isActive = true
        }
        careerTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: careerAreaView.leadingAnchor, constant: 40).isActive = true
            $0.trailingAnchor.constraint(equalTo: careerAreaView.trailingAnchor, constant: -40).isActive = true
        }
        careerDescript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerTitle.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: careerAreaView.leadingAnchor, constant: 40).isActive = true
            $0.trailingAnchor.constraint(equalTo: careerAreaView.trailingAnchor, constant: -40).isActive = true
        }
        
        // 프로젝트 요소
        projectLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectAreaView.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: projectAreaView.leadingAnchor, constant: 24).isActive = true
        }
        projectTitle.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: projectAreaView.leadingAnchor, constant: 40).isActive = true
            $0.trailingAnchor.constraint(equalTo: projectAreaView.trailingAnchor, constant: -40).isActive = true
        }
        projectDescript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectTitle.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: projectAreaView.leadingAnchor, constant: 40).isActive = true
            $0.trailingAnchor.constraint(equalTo: projectAreaView.trailingAnchor, constant: -40).isActive = true
        }
        
        // SNS 요소
        snsLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsAreaView.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: snsAreaView.leadingAnchor, constant: 24).isActive = true
        }
        
        // Email 요소
        emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailAreaView.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: emailAreaView.leadingAnchor, constant: 24).isActive = true
        }
        email.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: emailAreaView.leadingAnchor, constant: 40).isActive = true
            $0.trailingAnchor.constraint(equalTo: emailAreaView.trailingAnchor, constant: -40).isActive = true
        }
        
        // 활동지역 요소
        locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationAreaView.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: locationAreaView.leadingAnchor, constant: 24).isActive = true
        }
        location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: locationAreaView.leadingAnchor, constant: 40).isActive = true
            $0.trailingAnchor.constraint(equalTo: locationAreaView.trailingAnchor, constant: -40).isActive = true
        }
    }
}

extension ProfileModifyView: ProfileModifyViewProtocol {
    
}
