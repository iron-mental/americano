//
//  IntroProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol IntroViewProtocol: class {
    var presenter: IntroPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showLoading()
    func hideLoading()
    
    // success
    func presentNextView()
    func presentCompleteView()
    func completeSignUP()
    func completeJoin()
    
    // fail
    func showInvalidEmailAction(message: String)
    func showInvalidPasswordAction()
    func showInvalidNickNameAction(message: String)
    func showInvalidLoginAction(message: String)
    
    func showError(message: String)
}

protocol IntroWireFrameProtocol: class {
    static func createIntroModule(beginState: BeginState, introState: IntroViewState) -> UIViewController
    
    // PRESENT -> WIREFRAME
    func goToTermsOfServiceWeb(from view: IntroViewProtocol)
    func goToPrivacyWeb(from view: IntroViewProtocol)
}

protocol IntroPresenterProtocol: class {
    var view: IntroViewProtocol? { get set }
    var interactor: IntroInteractorProtocol? { get set }
    var wireFrame: IntroWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func didClickedRightBarButton(input: String, introState: IntroViewState, beginState: BeginState)
    func termsOfServiceDidTap()
    func privacyWebDidTap()
    
    // INTERACTOR -> PRESENTER
    func emailValidInfo(result: Bool, message: String)
    func passwordValidInfo(result: Bool)
    func nicknameValidInfo(result: Bool, message: String)
    func signUpValidInfo(result: Bool)
    func joinValidInfo(result: Bool, message: String)
    func sessionTaskError(message: String)
}

protocol IntroInteractorProtocol: class {
    var presenter: IntroPresenterProtocol? { get set }
    var remoteDataManager: IntroRemoteDataManagerProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func checkedEmailValid(input: String, beginState: BeginState)
    func checkedPasswordValid(input: String)
    func signUpValid(input: String)
    func checkedJoinValid(input: String)
    func sessionTaskError(message: String)
}

protocol IntroRemoteDataManagerProtocol: class {
    var interactor: IntroInteractorProtocol? { get set }
    
    func getEmailValidInfo(input: String, completionHandler: @escaping (BaseResponse<EmailValidteResult>) -> Void)
    func getSignUpValidInfo(signUpMaterial: [String], completionHandler: @escaping (BaseResponse<String>) -> Void)
    func getJoinValidInfo(joinMaterial: [String], completionHandler: @escaping (BaseResponse<JoinResult>) -> Void)
}

protocol IntroLocalDataManagerProtocol: class {
    var email: String { get set }
    var password: String { get set }
    var nickname: String { get set}
    
    func signUp(nickname: String) -> [String]
}
