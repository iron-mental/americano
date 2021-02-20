//
//  BaseProfileView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SafariServices
import Kingfisher
import SwiftKeychainWrapper

class BaseProfileView: UIViewController {
    
    // MARK: Init Property
    let scrollView      = UIScrollView()
    var backgroundView  = UIView()
    let profile         = ProfileView()
    let careerLabel     = UILabel()
    let career          = CareerView()
    let projectLabel    = UILabel()
    let project         = ProjectListView()
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
        [profile, career, sns, project, email, location].forEach {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
        }
        
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        self.scrollView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.showsVerticalScrollIndicator = false
        }
        
        self.backgroundView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        self.careerLabel.do {
            $0.text = "경력"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        
        self.projectLabel.do {
            $0.text = "프로젝트"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        
        self.snsLabel.do {
            $0.text = "SNS"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        
        self.emailLabel.do {
            $0.text = "Email"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        
        self.locationLabel.do {
            $0.text = "활동지역"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        
        self.sns.github.addTarget(self, action: #selector(goGithub), for: .touchUpInside)
        self.sns.linkedin.addTarget(self, action: #selector(goLinkedin), for: .touchUpInside)
        self.sns.web.addTarget(self, action: #selector(goWeb), for: .touchUpInside)
    }
    
    // MARK: Set Layout
    
    func layout() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(backgroundView)
        [profile, careerLabel, career, projectLabel, project,
         snsLabel, sns, emailLabel, email, locationLabel, location]
            .forEach { self.backgroundView.addSubview($0) }
        
        // 스크롤뷰 오토레이아웃
        self.scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        self.backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        }
        self.profile.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: profile.heightAnchor).isActive = true
        }
        self.careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: careerLabel.heightAnchor).isActive = true
        }
        self.career.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        }
        self.projectLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: career.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.project.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        }
        self.snsLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: project.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.sns.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: sns.heightAnchor).isActive = true
        }
        self.emailLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: sns.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.email.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: email.heightAnchor).isActive = true
        }
        self.locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
        self.location.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalTo: projectLabel.heightAnchor).isActive = true
        }
    }
}

extension BaseProfileView: BaseProfileViewProtocol {
    func showLoading() {
        LoadingRainbowCat.show()
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide()
    }
    
    func showUserInfo(userInfo: UserInfo) {
        var snsList: [String: String] = [:]
        self.userInfo = userInfo

        // MARK: Set User Info

        /// 프로필
        self.profile.name.text = userInfo.nickname
        self.profile.descript.text = userInfo.introduce ?? ""
        
        let imageURL = userInfo.image ?? ""
        self.profile.profileImage.kf.setImage(with: URL(string: imageURL),
                                                  placeholder: UIImage(named: "defaultProfile"),
                                                  options: [.requestModifier(RequestToken.token())])

        /// 경력
        if let careerTitle = userInfo.careerTitle,
           let careerContents = userInfo.careerContents {
            self.career.careerTitle.text = careerTitle
            self.career.careerContents.text = careerContents
        }

        /// SNS
        if let github = userInfo.snsGithub,
           let linkedin = userInfo.snsLinkedin,
           let web = userInfo.snsWeb {
            if !github.isEmpty {
                snsList.updateValue(github, forKey: SNSState.github.rawValue)
            }

            if !linkedin.isEmpty {
                snsList.updateValue(linkedin, forKey: SNSState.linkedin.rawValue)
            }

            if !web.isEmpty {
                snsList.updateValue(web, forKey: SNSState.web.rawValue)
            }
        }

        self.sns.addstack(snsList: snsList)

        /// 이메일
        self.email.email.text = userInfo.email

        /// 활동지역
        let sido = userInfo.sido ?? ""
        let sigungu = userInfo.sigungu ?? ""
        self.location.location.text = sido + " " + sigungu
        
        // hide loading
        self.hideLoading()
    }

    func addProjectToStackView(project: [Project]) {
        self.projectData = project

        /// 기존의 프로젝트 스택뷰에 요소들을 셋팅 전에 모두 제거
        self.project.projectStack.removeAllArrangedSubviews()

        for data in project {
            let title = data.title
            let contents = data.contents

            let projectView = ProjectView(title: title,
                                          contents: contents,
                                          snsGithub: data.snsGithub ?? "",
                                          snsAppStore: data.snsAppstore ?? "",
                                          snsPlayStore: data.snsPlaystore ?? "",
                                          frame: CGRect.zero)
           
            self.project.projectStack.addArrangedSubview(projectView)
        }
    }
}


// MARK: @objc

extension BaseProfileView {
    
    /// Profile SNS
    @objc func goGithub() {
        guard let address = self.userInfo?.snsGithub,
              let url = URL(string: "https://www.github.com/\(address)") else { return }
        let webView = SFSafariViewController(url: url)
        self.present(webView, animated: true, completion: nil)
    }
    
    @objc func goLinkedin() {
        guard let address = self.userInfo?.snsLinkedin,
              let url = URL(string: address) else { return }
        let webView = SFSafariViewController(url: url)
        self.present(webView, animated: true, completion: nil)
    }
    
    @objc func goWeb() {
        guard let address = self.userInfo?.snsWeb,
              let url = URL(string: address) else { return }
        let webView = SFSafariViewController(url: url)
        self.present(webView, animated: true, completion: nil)
    }
}
