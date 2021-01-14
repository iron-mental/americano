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

class ProfileDetailView: BaseProfileView {
    // MARK: Init Property
    var presenter: ProfileDetailPresenterProtocol?
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    // MARK: Set Attribute
    override func attribute() {
        super.attribute()
        self.profile.modify.addTarget(self, action: #selector(modifyProfile), for: .touchUpInside)
        self.career.modify.addTarget(self, action: #selector(modifyCareer), for: .touchUpInside)
        self.sns.modify.addTarget(self, action: #selector(modifySNS), for: .touchUpInside)
        self.email.modify.addTarget(self, action: #selector(modifyEmail), for: .touchUpInside)
        self.location.modify.addTarget(self, action: #selector(modifyLocation), for: .touchUpInside)
    }
    
    // MARK: Set Layout
    override func layout() {
        super.layout()
    }
    
    @objc func modifyProfile() {
        let profileImage = profile.profileImage.image ?? UIImage(named: "managerImage")!
        let name = profile.name.text ?? "none"
        let introduction = profile.descript.text ?? "none"
        let profile = Profile(profileImage: profileImage, nickname: name, introduction: introduction)
        
        presenter?.showProfileModify(profile: profile)
    }
    
    @objc func modifyCareer() {
        let title = career.careerTitle.text ?? ""
        let contents = career.careerContents.text ?? ""
        presenter?.showCareerModify(title: title, contents: contents)
    }
    
    @objc func modifyProject() {
        let project: [Project] = projectData
        presenter?.showProjectModify(project: project)
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
    
    func addProjectToStackView(with project: [Project]) {
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
        
        let addProjectButton = UIButton().then {
            $0.setTitle("프로젝트 수정", for: .normal)
            $0.setTitleColor(.appColor(.mainColor), for: .normal)
            $0.addTarget(self, action: #selector(modifyProject), for: .touchUpInside)
        }
        self.projectStack.addArrangedSubview(addProjectButton)
    }
}
