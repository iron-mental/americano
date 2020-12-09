//
//  SetViewPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SetPresenter: SetPresenterProtocol {
    var view: SetViewProtocol?
    var interactor: SetInteractortInputProtocol?
    var wireFrame: SetWireFrameProtocol?
    
    func viewDidLoad(id: Int) {
        interactor?.getUserInfo(id: id)
    }
    
    func showProfileDetail() {
        wireFrame?.presentProfileDetailScreen(from: view!)
    }
    
    func loggedOut() {
        view?.loggedOut()
    }
}

extension SetPresenter: SetInteractorOutputProtocol {
    func didRetrievedUserInfo(userInfo: UserInfo) {
        view?.showUserInfo(with: userInfo)
    }
    
    func onError() {
        
    }
}
