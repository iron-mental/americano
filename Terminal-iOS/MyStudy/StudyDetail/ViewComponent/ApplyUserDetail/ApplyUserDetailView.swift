//
//  ApplyUserDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/18.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Kingfisher

class ApplyUserDetailView: BaseProfileView {
    var presenter: ApplyUserDetailPresenterInputProtocol?
    
    let applyMessageLabel = UILabel()
    let applyMessage = ApplyMessageView()
    let refusalButton = UIButton()
    let acceptButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func attribute() {
        super.attribute()
        
        self.applyMessageLabel.do {
            $0.text = "가입인사"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 15, weight: .regular)
        }
        
        self.applyMessage.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .appColor(.cellBackground)
        }
        
        self.refusalButton.do {
            $0.setTitle("거절", for: .normal)
            $0.layer.cornerRadius = 10
            $0.titleLabel?.dynamicFont(fontSize: 15, weight: .semibold)
            $0.backgroundColor = UIColor.systemRed
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(rejectButtonDidTap), for: .touchUpInside)
        }
        
        self.acceptButton.do {
            $0.setTitle("수락", for: .normal)
            $0.layer.cornerRadius = 10
            $0.titleLabel?.dynamicFont(fontSize: 15, weight: .semibold)
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(acceptButtonDidTap), for: .touchUpInside)
        }
        
        [ profile.modify, career.modify, project.modify, sns.modify, email.modify, location.modify]
            .forEach { $0.isHidden = true}
    }
    
    override func layout() {
        super.layout()

        [applyMessageLabel, applyMessage, refusalButton, acceptButton]
            .forEach { self.backgroundView.addSubview($0) }
        
        self.applyMessageLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.location.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                        constant: Terminal.convertHeight(value: 25)).isActive = true
        }
        
        self.applyMessage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.applyMessageLabel.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 5)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor,
                                        constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor,
                                         constant: Terminal.convertHeight(value: -15)).isActive = true
            $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        }

        self.refusalButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.applyMessage.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                        constant: Terminal.convertHeight(value: 45)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 35)).isActive = true
        }
        
        self.acceptButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.applyMessage.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                         constant: Terminal.convertHeight(value: -45)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 35)).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor).isActive = true
        }
    }
    
    // MARK: @objc
    @objc func rejectButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .RejectUserView)
        TerminalAlertMessage.getRightButton().addTarget(self, action: #selector(rejectUserButtonDidTap), for: .touchUpInside)
    }
    
    @objc func acceptButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .AllowUserView)
        TerminalAlertMessage.getRightButton().addTarget(self, action: #selector(allowUserButtonDidTap), for: .touchUpInside)
    }
    
    @objc func allowUserButtonDidTap() {
        presenter?.acceptButtonDidtap()
        TerminalAlertMessage.dismiss()
    }
    
    @objc func rejectUserButtonDidTap() {
        presenter?.rejectButtonDidTap()
        TerminalAlertMessage.dismiss()
    }
}

extension ApplyUserDetailView: ApplyUserDetailViewProtocol {
    
    // MARK: Set User Info
    
    func showUserInfo(userInfo: ApplyUserInfo) {
        var snsList: [String: String] = [:]
      
        /// 프로필
        self.profile.name.text = userInfo.nickname
        
        let imageURL = userInfo.image ?? ""
        self.profile.profileImage.kf.setImage(with: URL(string: imageURL),
                                              placeholder: UIImage(named: "defaultProfile"),
                                              options: [.requestModifier(RequestToken.token())])
        
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
        
        /// 가입인사
        self.applyMessage.message.text = userInfo.message
        
        /// 프로젝트
        self.addProjectToStackView(project: userInfo.project)
        
    }
    
    func showApplyStatusResult(message: String, studyID: Int) {
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
            if let applyUserListView = self.navigationController?.viewControllers.last as? ApplyUserViewProtocol {
                applyUserListView.presenter?.viewDidLoad(studyID: studyID)
                self.navigationController?.viewControllers.forEach {
                    if let myStudyDetailView = $0 as? MyStudyDetailViewProtocol {
                        if let studyDetailView =  myStudyDetailView.vcArr[1] as? StudyDetailViewProtocol {
                            studyDetailView.presenter?.showStudyListDetail(studyID: String(studyID))
                        }
                    }
                }
            }
        }
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}
