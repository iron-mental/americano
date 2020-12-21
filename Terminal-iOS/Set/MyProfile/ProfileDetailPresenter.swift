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
    
    func showProfileModify(userInfo: UserInfo, project: [Project]) {
        wireFrame?.presentProfileModifyScreen(from: view!, userInfo: userInfo, project: project)
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
    
    func showCareerModify() {
        wireFrame?.presentCareerModify(from: view!)
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
