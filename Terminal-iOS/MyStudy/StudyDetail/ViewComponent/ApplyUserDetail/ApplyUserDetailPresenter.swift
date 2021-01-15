//
//  ApplyUserDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ApplyUserDetailPresenter: ApplyUserDetailPresenterInputProtocol {
    var view: ApplyUserDetailViewProtocol?
    var interactor: ApplyUserDetailInteractorInputProtocol?
    var wireFrame: ApplyUserDetailWireFrameProtocol?
    
    func viewDidLoad(userID: Int) {
        LoadingRainbowCat.show()
        interactor?.getUserInfo(userID: userID)
    }
}

extension ApplyUserDetailPresenter: ApplyUserDetailInteractorOutputProtocol {
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
