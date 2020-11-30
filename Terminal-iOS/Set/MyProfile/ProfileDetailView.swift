//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/06.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

import Kingfisher

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
    var userInfo: UserInfo?
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad(id: 1)
    }
    
    // MARK: Set Attribute
    
    func attribute() {
        let modifyBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "modifiy"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(pushProfileModify))
        
        [profile, career, sns, projectStack,email, location].forEach {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
        }
        
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationItem.rightBarButtonItem = modifyBtn
        }

        careerLabel.do {
            $0.text = "경력"
            $0.textColor = .white
        }
        
        projectLabel.do {
            $0.text = "프로젝트"
            $0.textColor = .white
        }
        
        snsLabel.do {
            $0.text = "SNS"
            $0.textColor = .white
        }
        
        emailLabel.do {
            $0.text = "Email"
            $0.textColor = .white
        }
        
        locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .white
        }
        
        projectStack.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
    }
    
    // MARK: Set Layout
    
    func layout() {
        view.addSubview(scrollView)
        [profile, careerLabel, career, projectLabel, projectStack, snsLabel, sns, emailLabel,email, locationLabel, location]
            .forEach { scrollView.addSubview($0) }
        
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
        careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: careerLabel.heightAnchor).isActive = true
        }
        career.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: career.heightAnchor).isActive = true
        }
        projectLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: career.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        projectStack.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: projectStack.heightAnchor).isActive = true
        }
        snsLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectStack.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: sns.heightAnchor).isActive = true
        }
        emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: sns.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        email.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: email.heightAnchor).isActive = true
        }
        locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    }
    
    @objc func pushProfileModify() {
        guard let userInfo = self.userInfo else { return }
        presenter?.showProfileModify(userInfo: userInfo)
    }
}

extension ProfileDetailView: ProfileDetailViewProtocol {
    func showUserInfo(with userInfo: UserInfo) {
        self.userInfo = userInfo
        /// Kingfisher auth token
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue(Terminal.token, forHTTPHeaderField: "Authorization")
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
        for data in project {
            let title = data.title
            let contents = data.contents
            
            let projectView = ProjectView(title: title, contents: contents, frame: CGRect.zero)
            
            projectStack.addArrangedSubview(projectView)
        }
    }
}
