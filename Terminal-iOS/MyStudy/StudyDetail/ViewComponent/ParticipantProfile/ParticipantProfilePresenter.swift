//
//  ParticipantProfilePresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/24.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ParticipantProfilePresenter: ParticipantProfilePresenterProtocol {
    weak var view: ParticipantProfileViewProtocol?
    var interactor: ParticipantProfileInteractorInputProtocol?
    var wireFrame: ParticipantProfileWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getUserInfo()
    }
}

extension ParticipantProfilePresenter: ParticipantProfileInteractorOutputProtocol {
    func retriveUserInfo(result: Bool, userInfo: UserInfo) {
        view?.hideLoading()
        self.view?.showUserInfo(userInfo: userInfo)
    }
    
    func retriveProjectList(result: Bool, projectList: [Project]) {
        view?.hideLoading()
        self.view?.addProjectToStackView(project: projectList)
    }
    
    func showError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
