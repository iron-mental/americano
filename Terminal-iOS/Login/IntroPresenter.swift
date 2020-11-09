//
//  IntroViewPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class IntroPresenter: IntroPresenterProtocol {
    
    
    var view: IntroViewProtocol?
    var interactor: IntroInteractorProtocol?
    
    func didClickedRightBarButton(input: String, state: IntroViewState) {
        print(state)
        switch state {
        case .emailInput:
            interactor?.checkedEmailValid(input: input)
            break
        case .pwdInput:
            interactor?.checkedPasswordValid(input: input)
            break
        case .nickname:
            interactor?.signUpValid(input: input)
            break
        }
    }
    
    func emailValidInfo(result: Bool) {
        result ? view?.presentNextView() : view?.showInvalidEmailAction()
    }
    
    func passwordValidInfo(result: Bool) {
        result ? view?.presentNextView() : view?.showInvalidPasswordAction()
    }
    
    func signUpValidInfo(result: Bool) {
        view?.presentCompleteView()
    }
}
