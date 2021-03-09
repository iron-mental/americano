//
//  IntroViewPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class IntroPresenter: IntroPresenterProtocol {
    weak var view: IntroViewProtocol?
    var interactor: IntroInteractorProtocol?
    var wireFrame: IntroWireFrameProtocol?
    
    func didClickedRightBarButton(input: String, introState: IntroViewState, beginState: BeginState) {
        switch introState {
        case .emailInput:
            interactor?.checkedEmailValid(input: input, beginState: beginState)
        case .pwdInput:
            beginState == .signUp ? interactor?.checkedPasswordValid(input: input) : interactor?.checkedJoinValid(input: input)
            beginState == .signUp ? nil : view?.showLoading()
        case .nickname:
            view?.showLoading()
            interactor?.signUpValid(input: input)
        }
    }
    
    /// 이메일 유효성 확인 
    func emailValidInfo(result: Bool, message: String) {
        result ? view?.presentNextView() : view?.showInvalidEmailAction(message: message)
    }
    
    /// 패스워드 유효성 확인
    func passwordValidInfo(result: Bool) {
        result ? view?.presentNextView() : view?.showInvalidPasswordAction()
    }
    
    func nicknameValidInfo(result: Bool, message: String) {
        view?.hideLoading()
        result ? view?.presentNextView() : view?.showInvalidNickNameAction(message: message)
    }
    
    /// 회원가입 유효성 확인
    func signUpValidInfo(result: Bool) {
        switch result {
        case true:
            view?.hideLoading()
            view?.completeSignUP()
        case false:
            view?.hideLoading()
        }
    }
    
    /// 로그인 유효성 확인
    func joinValidInfo(result: Bool, message: String) {
        result ? view?.completeJoin() : view?.showInvalidLoginAction(message: message)
        result ? nil : view?.hideLoading()
    }
    
    func didNextButton(input: String, introState: IntroViewState, beginState: BeginState) {
        switch introState {
        case .emailInput:
            interactor?.checkedEmailValid(input: input, beginState: beginState)
        case .pwdInput:
            beginState == .signUp ? interactor?.checkedPasswordValid(input: input) : interactor?.checkedJoinValid(input: input)
        case .nickname:
            interactor?.signUpValid(input: input)
        }
    }
    
    func termsOfServiceDidTap() {
        wireFrame?.goToTermsOfServiceWeb(from: view!)
    }
    
    func privacyWebDidTap() {
        wireFrame?.goToPrivacyWeb(from: view!)
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
