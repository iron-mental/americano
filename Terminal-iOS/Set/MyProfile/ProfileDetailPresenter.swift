//
//  ProfileModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ProfileDetailPresenter: ProfileDetailPresenterProtocol {
    var view: ProfileDetailViewProtocol?
    var interactor: ProfileDetailInteractorInputProtocol?
    var wireFrame: ProfileDetailWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.getUserInfo()
        interactor?.getProjectList()
    }
    
    func showProfileModify(profile: Profile) {
        wireFrame?.presentProfileModify(from: view!, profile: profile)
    }
    
    func showEmailModify() {
        wireFrame?.presentEmailModify(from: view!)
    }
    
    func showSNSModify() {
        wireFrame?.presentSNSModify(from: view!)
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
        view?.showUserInfo(with: userInfo)
    }
    
    func didRetrievedProject(project: [Project]) {
        view?.addProjectToStackView(with: project)
    }
}
