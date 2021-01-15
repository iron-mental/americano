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
        self.location.do {
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
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
        let github = userInfo?.snsGithub ?? ""
        let linkedin = userInfo?.snsLinkedin ?? ""
        let web = userInfo?.snsWeb ?? ""
        presenter?.showSNSModify(github: github, linkedin: linkedin, web: web)
    }
    
    @objc func modifyEmail() {
        presenter?.showEmailModify()
    }
    
    @objc func modifyLocation() {
        presenter?.showLocationModify()
    }
}

extension ProfileDetailView: ProfileDetailViewProtocol {
}
