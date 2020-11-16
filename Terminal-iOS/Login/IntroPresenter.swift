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
    
    func didClickedRightBarButton(input: String, introState: IntroViewState, beginState: BeginState) {
        
        switch introState {
        case .emailInput:
            interactor?.checkedEmailValid(input: input, beginState: beginState)
            break
        case .pwdInput:
            beginState == .signUp ? interactor?.checkedPasswordValid(input: input) : interactor?.checkedJoinValid(input: input)
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
    func joinValidInfo(result: Bool, joinInfo: String) {
        result ? view?.presentCompleteView() : print(joinInfo)
    }
}
