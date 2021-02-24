//
//  SetViewPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SetPresenter: SetPresenterProtocol {
    weak var view: SetViewProtocol?
    var interactor: SetInteractortInputProtocol?
    var wireFrame: SetWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getUserInfo()
    }
    
    func showProfileDetail() {
        wireFrame?.presentProfileDetailScreen(from: view!)
    }
    
    func emailAuthRequest() {
        interactor?.emailAuthRequest()
    }
    
    func loggedOut() {
        view?.loggedOut()
    }
    
    func userWithdrawal() {
        wireFrame?.presentUserWithdrawal(from: view!)
    }
    
    func loggedOutConfirmed() {
        interactor?.removeRefreshToken()
    }
    
    func notiCellDidTap() {
        view?.showNotiSettingAlertView()
    }
    
    func goToSettingApp() {
        wireFrame?.goToSettingApp()
    }
}

extension SetPresenter: SetInteractorOutputProtocol {
    func didRetrievedUserInfo(userInfo: UserInfo) {
        view?.showUserInfo(with: userInfo)
    }
    
    func eamilAuthResponse(result: Bool, message: String) {
        view?.emailAuthResponse(result: result, message: message)
    }
    
    func logoutResult(result: BaseResponse<String>) {
        switch result.result {
        case true:
            wireFrame?.replaceRootViewToIntroView(from: view!)
        case false:
            guard let message = result.message else { return }
            view?.showError(message: message)
        }
    }
    
    func onError() {
        
    }
}
