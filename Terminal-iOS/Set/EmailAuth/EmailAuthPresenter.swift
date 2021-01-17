//
//  EmailAuthPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class EmailAuthPresenter: EmailAuthPresenterProtocol {
    var view: EmailAuthViewProtocol?
    var wireframe: EmailAuthWireFrameProtocol?
    var interactor: EmailAuthInteractorInputProtocol?
    
    func emailAuthRequest() {
        interactor?.emailAuthRequest()
    }
}

extension EmailAuthPresenter: EmailAuthInteractorOutputProtocol {
    func eamilAuthResponse(result: Bool, message: String) {
        view?.emailAuthResponse(result: result, message: message)
    }
}
