//
//  EmailModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class EmailModifyPresenter: EmailModifyPresenterProtocol {
    weak var view: EmailModifyViewProtocol?
    var interactor: EmailModifyInteractorInputProtocol? 
    var wireFrame: EmailModifyWireFrameProtocol?
    
    func completeModify(email: String) {
        interactor?.completeModify(email: email)
    }
}

extension EmailModifyPresenter: EmailModifyInteractorOutputProtocol {
    func didCompleteModify(result: Bool, message: String) {
        view?.modifyResultHandle(result: result, message: message)
    }
}
