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
    func goToIntroView() {
        wireframe?.goToIntroView(from: view!)
    }
}

extension UserWithdrawalPresenter: UserWithdrawalInteractorOutputProtocol {
    func resultUserWithdrawal(result: Bool, message: String) {
        switch result {
        case true:
            view?.resultUserWithdrawal(message: nil)
        case false:
            view?.resultUserWithdrawal(message: message)
        }
    }
}
