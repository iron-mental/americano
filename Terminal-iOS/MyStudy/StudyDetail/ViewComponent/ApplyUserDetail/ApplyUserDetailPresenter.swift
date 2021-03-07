//
//  ApplyUserDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ApplyUserDetailPresenter: ApplyUserDetailPresenterInputProtocol {
    weak var view: ApplyUserDetailViewProtocol?
    var interactor: ApplyUserDetailInteractorInputProtocol?
    var wireFrame: ApplyUserDetailWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getUserInfo()
    }
    
    func rejectButtonDidTap() {
        view?.showLoading()
        interactor?.postRejectStatus()
    }
    
    func acceptButtonDidtap() {
        view?.showLoading()
        interactor?.postAcceptStatus()
    }
    
}

extension ApplyUserDetailPresenter: ApplyUserDetailInteractorOutputProtocol {
    func retriveUserInfo(result: Bool, userInfo: ApplyUserInfo) {
        view?.hideLoading()
        switch result {
        case true:
            self.view?.showUserInfo(userInfo: userInfo)
        case false:
            print("ApplyUserDetailPresenter 에서 생긴 에러")
        }
    }
    
    func retriveApplyStatus(result: Bool, message: String, studyID: Int) {
        view?.hideLoading()
        switch result {
        case true:
            view?.showApplyStatusResult(message: message, studyID: studyID)
        case false:
            view?.showError(message: message)
        }
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
