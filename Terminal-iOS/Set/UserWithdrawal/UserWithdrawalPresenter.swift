//
//  UserWithdrawalPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class UserWithdrawalPresenter: UserWithdrawalPresenterProtocol {
    var view: UserWithdrawalViewProtocol?
    var interactor: UserWithdrawalInteractorInputProtocol?
    var wireframe: UserWithdrawalWireFrameProtocol?
    
    func userWithdrawal(email: String, password: String) {
        interactor?.userWithdrawal(email: email, password: password)
    }
}

extension UserWithdrawalPresenter: UserWithdrawalInteractorOutputProtocol {
    func resultUserWithdrawal(result: Bool, message: String) {
        result ? view?.resultUserWithdrawal(message: nil):
            view?.resultUserWithdrawal(message: message)
    }
}
