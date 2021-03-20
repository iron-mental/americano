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
    var profileState: Bool?
    
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
            $0.backgroundColor = .appColor(.cellBackground)
        }
        
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        
        self.scrollView.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.showsVerticalScrollIndicator = false
        }
        
        self.backgroundView.do {
            $0.backgroundColor = .appColor(.terminalBackground)
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
        self.email.do {
            $0.accountButton.do {
                guard let emailVerified = userInfo?.emailVerified else { return }
                if emailVerified {
                    $0.setTitle("인증완료", for: .normal)
                    $0.setTitleColor(.appColor(.mainColor), for: .normal)
                    $0.backgroundColor = .appColor(.eamilAuthComplete)
                } else {
                    $0.setTitle("미인증", for: .normal)
                    $0.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
                    $0.backgroundColor = .appColor(.emailAuthRequire)
                }
            }
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
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}

extension BaseProfileView: BaseProfileViewProtocol {
    
    // MARK: Set User Info
    
    func showUserInfo(userInfo: UserInfo) {
        var snsList: [String: String] = [:]
        self.userInfo = userInfo
        self.attribute()
        // MARK: Set User Info
      
        /// 프로필
        self.profile.name.text = userInfo.nickname
        self.profile.descript.text = userInfo.introduce ?? ""
        
        if let imageURL = userInfo.image {
            self.profile.profileImage.kf.setImage(with: URL(string: imageURL),
                                                  placeholder: UIImage(named: "defaultProfile"),
                                                  options: [.requestModifier(RequestToken.token())])
            self.profileState = imageURL.isEmpty ? false : true
        } else {
            self.profile.profileImage.image = UIImage(named: "defaultProfile")
            self.profileState = false
        }
        
        self.profile.attribute()
        /// 경력
        let careerTitle = userInfo.careerTitle ?? ""
        let careerContents = userInfo.careerContents ?? ""
        self.career.careerTitle.text = careerTitle
        self.career.careerContents.text = careerContents
        
        self.career.emptyMessage.isHidden =
            careerTitle.isEmpty && careerContents.isEmpty
            ? false
            : true
        
        /// SNS
        let github = userInfo.snsGithub ?? ""
        let linkedin = userInfo.snsLinkedin ?? ""
        let web = userInfo.snsWeb ?? ""
        snsList.updateValue(github, forKey: SNSState.github.rawValue)
        snsList.updateValue(linkedin, forKey: SNSState.linkedin.rawValue)
        snsList.updateValue(web, forKey: SNSState.web.rawValue)
        
        self.sns.addstack(snsList: snsList)
        
        /// 이메일
        self.email.email.text = userInfo.email
        
        /// 활동지역
        let sido = userInfo.sido ?? ""
        let sigungu = userInfo.sigungu ?? ""
        self.location.location.text = sido + " " + sigungu
        
        self.location.emptyMessage.isHidden =
            sido.isEmpty && sigungu.isEmpty
            ? false
            : true
        
        // hide loading
        self.hideLoading()
    }
    
    func addProjectToStackView(project: [Project]) {
        self.projectData = project
        
        /// 기존의 프로젝트 스택뷰에 요소들을 셋팅 전에 모두 제거
        self.project.projectStack.removeAllArrangedSubviews()
        
        /// 프로젝트 유무에 따른 empty message 상태처리
        self.project.emptyMessage.isHidden = project.isEmpty ? false : true
        
        for data in project {
            let title = data.title
            let contents = data.contents
            
            let projectView = ProjectView(title: title,
                                          contents: contents,
                                          snsGithub: data.snsGithub ?? "",
                                          snsAppStore: data.snsAppstore ?? "",
                                          snsPlayStore: data.snsPlaystore ?? "",
                                          frame: CGRect.zero)
            
            guard let viewID = data.id else { return }
            projectView.accessibilityIdentifier = String(viewID)
            projectView.sns.github.addTarget(self, action: #selector(projectSNSButtonDidTap(_: )), for: .touchUpInside)
            projectView.sns.appStore.addTarget(self, action: #selector(projectSNSButtonDidTap(_: )), for: .touchUpInside)
            projectView.sns.playStore.addTarget(self, action: #selector(projectSNSButtonDidTap(_: )), for: .touchUpInside)
            
            self.project.projectStack.addArrangedSubview(projectView)
        }
    }
}

// MARK: @objc

extension BaseProfileView {
    
    /// Profile SNS
    @objc func goGithub() {
        if let unWrappedURL = self.userInfo?.snsGithub {
            if unWrappedURL.isEmpty {
                self.showToast(controller: self, message: "해당 SNS가 존재하지 않습니다.", seconds: 1)
            } else {
                guard let url = URL(string: "https://www.github.com/\(unWrappedURL)") else { return }
                let webView = SFSafariViewController(url: url)
                self.present(webView, animated: true, completion: nil)
            }
        }
    }
    
    @objc func goLinkedin() {
        guard let unWrappedURL = self.userInfo?.snsLinkedin,
              let url = URL(string: unWrappedURL) else {
            self.showToast(controller: self, message: "해당 SNS가 존재하지 않습니다.", seconds: 1)
            return
        }
        let webView = SFSafariViewController(url: url)
        self.present(webView, animated: true, completion: nil)
    }
    
    @objc func goWeb() {
        guard let unWrappedURL = self.userInfo?.snsWeb,
              let url = URL(string: unWrappedURL) else {
            self.showToast(controller: self, message: "해당 SNS가 존재하지 않습니다.", seconds: 1)
            return
        }
        let webView = SFSafariViewController(url: url)
        self.present(webView, animated: true, completion: nil)
    }
    
    /// Project SNS
    @objc func projectSNSButtonDidTap(_ sender: UIButton ) {
        if let projectID    = sender.superview?.superview?.superview?.accessibilityIdentifier,
           let buttonID     = sender.accessibilityIdentifier {
            if let castedProjectID = Int(projectID) {
                var url: String?
                
                let selectedProject = projectData.filter { $0.id == castedProjectID }.last
                
                switch buttonID {
                case "github":
                    guard let github = selectedProject?.snsGithub else { return }
                    url = github.isEmpty
                        ? ""
                        : "https://www.github.com/\(github)"
                case "appStore":
                    url = selectedProject?.snsAppstore
                case "playStore":
                    url = selectedProject?.snsPlaystore
                default: break
                }
                
                guard let unWrappedURL = url,
                      let destination = URL(string: unWrappedURL) else {
                    self.showToast(controller: self, message: "해당 SNS가 존재하지 않습니다.", seconds: 1)
                    return
                }
                
                let webView = SFSafariViewController(url: destination)
                self.present(webView, animated: true, completion: nil)
            }
        }
    }
}
