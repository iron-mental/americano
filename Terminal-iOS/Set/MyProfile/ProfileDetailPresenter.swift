//
//  ProfileModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class ProfileDetailPresenter: ProfileDetailPresenterProtocol {
    weak var view: ProfileDetailViewProtocol?
    var interactor: ProfileDetailInteractorInputProtocol?
    var wireFrame: ProfileDetailWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getUserInfo()
        interactor?.getProjectList()
    }
    
    func showProfileModify(profile: Profile) {
        view?.showLoading()
        wireFrame?.presentProfileModify(from: view!, profile: profile)
    }
    
    func showEmailModify(email: String) {
        wireFrame?.presentEmailModify(from: view!, email: email)
    }
    
    func showSNSModify(github: String, linkedin: String, web: String) {
        wireFrame?.presentSNSModify(from: view!, github: github, linkedin: linkedin, web: web)
    }
 
    func showLocationModify() {
        wireFrame?.presentLocationModify(from: view!)
    }
    
    func showCareerModify(title: String, contents: String) {
        wireFrame?.presentCareerModify(from: view!, title: title, Contents: contents)
    }
    
    func showProjectModify(project: [Project]) {
        wireFrame?.presentProjectModify(from: view!, project: project)
    }
}

extension ProfileDetailPresenter: ProfileDetailInteractorOutputProtocol {
    func didRetrievedUserInfo(userInfo: UserInfo) {
        view?.showUserInfo(userInfo: userInfo)
    }
    
    func didRetrievedProject(project: [Project]) {
        view?.addProjectToStackView(project: project)
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
