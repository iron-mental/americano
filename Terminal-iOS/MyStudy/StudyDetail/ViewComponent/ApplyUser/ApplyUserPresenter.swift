//
//  ApplyUserPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ApplyUserPresenter: ApplyUserPresenterProtocol {
    weak var view: ApplyUserViewProtocol?
    var interactor: ApplyUserInteractorInputProtocol?
    var wireFrame: ApplyUserWireFrameProtocol?
    
    func viewDidLoad(studyID: Int) {
        view?.showLoading()
        interactor?.getApplyList(studyID: studyID)
    }
    
    func showUserInfoDetail(userInfo: ApplyUser, studyID: Int) {
        wireFrame?.presentUserInfoDetailScreen(from: view!, userInfo: userInfo, studyID: studyID)
    }
}


extension ApplyUserPresenter: ApplyUserInteractorOutputProtocol {
    func didRetrieveUser(result: BaseResponse<[ApplyUser]>) {
        switch result.result {
        case true:
            view?.hideLoading()
            guard let userList = result.data else { return }
            self.view?.showUserList(userList: userList)
        case false:
            view?.hideLoading()
            guard let message = result.message else { return }
            view?.showError(message: message)
        }
    }
}
