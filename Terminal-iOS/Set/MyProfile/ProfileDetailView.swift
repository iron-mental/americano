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
    let scrollView  = UIScrollView()
    let profile     = ProfileView()
    
    let carrer      = CarrerView()
    let projectStack = UIStackView()
    let sns         = SNSView()
    let email       = EmailView()
    let location    = LocationView()
    
    
    var projectArr: [UIView] = []
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad(id: 1)
    }
    
    // MARK: Set Attribute
    
    func attribute() {
        let modifyBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "modifiy"), style: .plain, target: self, action: #selector(pushProfileModify))
        [carrer, sns, projectStack,email, location].forEach {
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
        }
        
        projectStack.do {
//            $0.backgroundColor = .red
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 20
        }
    }
    
    // MARK: Set Layout
    
    func layout() {
        view.addSubview(scrollView)
        [profile, carrer, sns, email, location, projectStack].forEach { scrollView.addSubview($0) }
        
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
        projectStack.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: carrer.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: projectStack.heightAnchor).isActive = true
        }
        sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectStack.bottomAnchor, constant: 15).isActive = true
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
    
    func addProjectToStackView() {
        
    }
    
    @objc func pushProfileModify() {
        let view = ProfileModifyView()
        view.nameModify.text = self.profile.name.text
        view.descripModify.text = self.profile.descript.text
        navigationController?.pushViewController(view, animated: false)
    }
}

extension ProfileDetailView: ProfileDetailViewProtocol {
    func showUserInfo(with userInfo: UserInfo) {
        
        /// Kingfisher auth token
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue(Terminal.token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        // MARK: Set User Info
        
        /// 프로필
        profile.name.text = userInfo.nickname
        guard let image = userInfo.image else { return }
        guard let introduce = userInfo.introduce else { return }
        profile.profileImage.kf.setImage(with: URL(string: image), options: [.requestModifier(imageDownloadRequest)])
        profile.descript.text = introduce
        
        /// 경력
        guard let careerTitle = userInfo.careerTitle else { return }
        guard let careerContents = userInfo.careerContents else { return }
        carrer.careerTitle.text = careerTitle
        carrer.careerContents.text = careerContents
        
        /// 이메일
        email.email.text = userInfo.email
        
        /// 활동지역
        guard let address = userInfo.address else { return }
        location.location.text = address
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
