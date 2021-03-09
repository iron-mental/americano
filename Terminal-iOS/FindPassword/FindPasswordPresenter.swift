//
//  FindPasswordPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

final class FindPasswordPresenter: FindPasswordPresenterProtocol {
    var view: FindPasswordViewProtocol?
    var interactor: FindPasswordInteractorInputProtocol?
    var wireFrame: FindPasswordWireFrameProtocol?
    
    func resetRequest(email: String) {
        self.view?.showLoading()
        self.interactor?.resetRequest(email: email)
    }
}

extension FindPasswordPresenter: FindPasswordInteractorOutputProtocol {
    func sessionTaskError(message: String) {
        self.view?.hideLoading()
        self.view?.showError(message: message)
    }
    
    func resetResponse(result: Bool, message: String) {
        self.view?.hideLoading()
        self.view?.showResult(result: result, message: message)
    }
}
