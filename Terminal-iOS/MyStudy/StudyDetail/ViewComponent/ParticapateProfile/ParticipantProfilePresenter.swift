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
        interactor?.getUserInfo()
    }
}

extension ParticipantProfilePresenter: ParticipantProfileInteractorOutputProtocol {
    func retriveUserInfo(result: Bool, userInfo: UserInfo) {
        switch result {
        case true:
            LoadingRainbowCat.hide {
                self.view?.showUserInfo(userInfo: userInfo)
            }
        case false:
            print("ApplyUserDetailPresenter 에서 생긴 에러")
        }
    }
    
    func retriveProjectList(result: Bool, projectList: [Project]) {
        switch result {
        case true:
            LoadingRainbowCat.hide {
                self.view?.addProjectToStackView(project: projectList)
            }
        case false:
            print("ApplyUserDetailPresenter")
        }
    }
}
