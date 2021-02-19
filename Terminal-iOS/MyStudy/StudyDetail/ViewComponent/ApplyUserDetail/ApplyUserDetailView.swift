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
    let refusalButton = UIButton()
    let acceptButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func attribute() {
        super.attribute()
        
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
        [acceptButton, refusalButton].forEach { backgroundView.addSubview($0) }
        
        self.refusalButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.location.bottomAnchor, constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Terminal.convertHeight(value: 45)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 35)).isActive = true
        }
        self.acceptButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.location.bottomAnchor, constant: Terminal.convertHeight(value: 15)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Terminal.convertHeight(value: -45)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 35)).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor).isActive = true
        }
    }
    
    // MARK: @objc
    @objc func rejectButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .RejectUserView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(rejectUserButtonDidTap), for: .touchUpInside)
    }
    
    @objc func acceptButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .AllowUserView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(allowUserButtonDidTap), for: .touchUpInside)
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
    func showApplyStatusResult(message: String, studyID: Int) {
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
            if let applyUserListView = self.navigationController?.viewControllers.last as? ApplyUserViewProtocol {
                applyUserListView.presenter?.viewDidLoad(studyID: studyID)
            }
        }
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    
}
