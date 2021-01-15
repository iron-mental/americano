//
//  BaseProfileView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

class BaseProfileView: UIViewController {
    
    // MARK: Init Property
    let scrollView      = UIScrollView()
    let profile         = ProfileView()
    
    let careerLabel     = UILabel()
    let career          = CareerView()
    let projectLabel    = UILabel()
    let projectStack    = UIStackView()
    let snsLabel        = UILabel()
    let sns             = ProfileSNSView()
    let emailLabel      = UILabel()
    let email           = EmailView()
    let locationLabel   = UILabel()
    let location        = LocationView()
    
    var projectData: [Project] = []
    var userInfo: UserInfo?
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    // MARK: Set Attribute
    
    func attribute() {
        [profile, career, sns, projectStack, email, location].forEach {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
        }
        
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }

        self.careerLabel.do {
            $0.text = "경력"
            $0.textColor = .white
        }
        
        self.projectLabel.do {
            $0.text = "프로젝트"
            $0.textColor = .white
        }
        
        self.snsLabel.do {
            $0.text = "SNS"
            $0.textColor = .white
        }
        
        self.emailLabel.do {
            $0.text = "Email"
            $0.textColor = .white
        }
        
        self.locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .white
        }
        
        self.projectStack.do {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 5
        }
    }
    
    // MARK: Set Layout
    
    func layout() {
        self.view.addSubview(scrollView)
        [profile, careerLabel, career, projectLabel, projectStack,
         snsLabel, sns, emailLabel,email, locationLabel, location]
            .forEach { self.scrollView.addSubview($0) }
        
        // 스크롤뷰 오토레이아웃
        self.scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        self.profile.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: profile.heightAnchor).isActive = true
        }
        self.careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: careerLabel.heightAnchor).isActive = true
        }
        self.career.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: career.heightAnchor).isActive = true
        }
        self.projectLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: career.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.projectStack.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: projectStack.heightAnchor).isActive = true
        }
        self.snsLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectStack.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: sns.heightAnchor).isActive = true
        }
        self.emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: sns.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.email.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: email.heightAnchor).isActive = true
        }
        self.locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    }
}

extension BaseProfileView: BaseProfileViewProtocol {
    
    func showUserInfo(userInfo: UserInfo) {
        var snsList: [String: String] = [:]
        self.userInfo = userInfo
        /// Kingfisher auth token
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }

        // MARK: Set User Info

        /// 프로필
        self.profile.name.text = userInfo.nickname

        if let image = userInfo.image, let introduce = userInfo.introduce {
            self.profile.descript.text = introduce
            self.profile.profileImage.kf.setImage(with: URL(string: image),
                                             options: [.requestModifier(imageDownloadRequest)])
        }

        /// 경력
        if let careerTitle = userInfo.careerTitle, let careerContents = userInfo.careerContents {
            self.career.careerTitle.text = careerTitle
            self.career.careerContents.text = careerContents
        }

        /// SNS
        if let github = userInfo.snsGithub,
           let linkedin = userInfo.snsLinkedin,
           let web = userInfo.snsWeb {
            if !github.isEmpty {
                snsList.updateValue(github, forKey: "github")
            }

            if !linkedin.isEmpty {
                snsList.updateValue(linkedin, forKey: "linkedin")
            }

            if !web.isEmpty {
                snsList.updateValue(web, forKey: "web")
            }
        }

        self.sns.addstack(snsList: snsList)

        /// 이메일
        self.email.email.text = userInfo.email

        /// 활동지역
        if let address = userInfo.address {
            self.location.location.text = address
        }
    }

    func addProjectToStackView(project: [Project]) {
        self.projectData = project

        /// 기존의 프로젝트 스택뷰에 요소들을 셋팅 전에 모두 제거
        self.projectStack.removeAllArrangedSubviews()

        for data in project {
            let title = data.title
            let contents = data.contents

            let projectView = ProjectView(title: title,
                                          contents: contents,
                                          snsGithub: data.snsGithub ?? "",
                                          snsAppStore: data.snsAppstore ?? "",
                                          snsPlayStore: data.snsPlaystore ?? "",
                                          frame: CGRect.zero)

            self.projectStack.addArrangedSubview(projectView)
        }
//
//        let addProjectButton = UIButton().then {
//            $0.setTitle("프로젝트 수정", for: .normal)
//            $0.setTitleColor(.appColor(.mainColor), for: .normal)
//            $0.addTarget(self, action: #selector(modifyProject), for: .touchUpInside)
//        }
//        self.projectStack.addArrangedSubview(addProjectButton)
    }
}
