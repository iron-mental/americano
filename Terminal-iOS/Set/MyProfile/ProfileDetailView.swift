//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/06.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

class ProfileDetailView: UIViewController {
    // MARK: Init Property
    
    var presenter: ProfileDetailPresenterProtocol?
    let scrollView      = UIScrollView()
    let profile         = ProfileView()
    
    let careerLabel     = UILabel()
    let career          = CareerView()
    let projectLabel    = UILabel()
    let projectStack    = UIStackView()
    let snsLabel        = UILabel()
    let sns             = SNSView()
    let emailLabel      = UILabel()
    let email           = EmailView()
    let locationLabel   = UILabel()
    let location        = LocationView()
    
    var projectArr: [UIView] = []
    var projectData: [Project] = []
    var userInfo: UserInfo?
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    // MARK: Set Attribute
    
    func attribute() {
        let modifyBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "modifiy"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(pushProfileModify))
        
        [profile, career, sns, projectStack, email, location].forEach {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
        }
        
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationItem.rightBarButtonItem = modifyBtn
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
        
        self.career.modify.addTarget(self, action: #selector(modifyCareer), for: .touchUpInside)
        self.sns.modify.addTarget(self, action: #selector(modifySNS), for: .touchUpInside)
        self.email.modify.addTarget(self, action: #selector(modifyEmail), for: .touchUpInside)
        self.location.modify.addTarget(self, action: #selector(modifyLocation), for: .touchUpInside)
        
        self.locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .white
        }
        
        self.projectStack.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
    }
    
    // MARK: Set Layout
    
    func layout() {
        self.view.addSubview(scrollView)
        [profile, careerLabel, career, projectLabel, projectStack, snsLabel, sns, emailLabel,email, locationLabel, location]
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
    
    @objc func pushProfileModify() {
        guard let userInfo = self.userInfo else { return }
        presenter?.showProfileModify(userInfo: userInfo, project: projectData)
    }
    
    @objc func modifyProfile() {
        
    }
    @objc func modifyCareer() {
        let title = career.careerTitle.text ?? ""
        let contents = career.careerContents.text ?? ""
        presenter?.showCareerModify(title: title, contents: contents)
    }
    @objc func modifySNS() {
        presenter?.showSNSModify()
    }
    @objc func modifyEmail() {
        presenter?.showEmailModify()
    }
    @objc func modifyLocation() {
        presenter?.showLocationModify()
    }
}

extension ProfileDetailView: ProfileDetailViewProtocol {
    func showUserInfo(with userInfo: UserInfo) {
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
        profile.name.text = userInfo.nickname
        
        if let image = userInfo.image, let introduce = userInfo.introduce {
            profile.descript.text = introduce
            profile.profileImage.kf.setImage(with: URL(string: image),
                                             options: [.requestModifier(imageDownloadRequest)])
        }
      
        /// 경력
        if let careerTitle = userInfo.careerTitle, let careerContents = userInfo.careerContents {
            career.careerTitle.text = careerTitle
            career.careerContents.text = careerContents
        }
        
        /// 이메일
        email.email.text = userInfo.email
        
        /// 활동지역
        if let address = userInfo.address {
            location.location.text = address
        }
    }
    
    func addProjectToStackView(with project: [Project]) {
        projectData = project
        
        for data in project {
            let title = data.title
            let contents = data.contents
            
            let projectView = ProjectView(title: title, contents: contents, frame: CGRect.zero)
            
            projectStack.addArrangedSubview(projectView)
        }
    }
}
