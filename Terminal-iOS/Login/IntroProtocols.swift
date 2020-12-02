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
    
    //PRESENTER -> VIEW
        //success
    func presentNextView()
    func presentCompleteView()
        //false
    func showInvalidEmailAction()
    func showInvalidPasswordAction()
    func showInvalidNickNameAction()
}

protocol IntroWireFrameProtocol: class {
    static func createIntroModule(beginState: BeginState, introState: IntroViewState) -> UIViewController
    
    // PRESENT -> WIREFRAME

}

protocol IntroPresenterProtocol: class {
    var view: IntroViewProtocol? { get set }
    var interactor: IntroInteractorProtocol? { get set }
    var wireFrame: IntroWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func didClickedRightBarButton(input: String, introState: IntroViewState, beginState: BeginState)
    
    //test
    func didNextButton(input: String, introState: IntroViewState, beginState: BeginState)
    
    //INTERACTOR -> PRESENTER
    func emailValidInfo(result: Bool)
    func passwordValidInfo(result: Bool)
    func nicknameValidInfo(result: Bool)
    func signUpValidInfo(result: Bool)
    func joinValidInfo(result: Bool, joinInfo: String)
}

protocol IntroInteractorProtocol: class {
    var presenter: IntroPresenterProtocol? { get set }
    var remoteDataManager: IntroRemoteDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func checkedEmailValid(input: String, beginState: BeginState)
    func checkedPasswordValid(input: String)
    func signUpValid(input: String)
    func checkedJoinValid(input: String)
}

protocol IntroRemoteDataManagerProtocol: class {
    func getEmailValidInfo(input: String, completionHandler: @escaping (BaseResponse<String>) -> Void)
    func getSignUpValidInfo(signUpMaterial: [String], completionHandler: @escaping (BaseResponse<String>) -> Void)
    func getJoinValidInfo(joinMaterial: [String], completionHandler: @escaping (BaseResponse<JoinResult>) -> Void)
}

protocol IntroLocalDataManagerProtocol: class {
    var email: String { get set }
    var password: String { get set }
    var nickname: String { get set}
    
    func signUp(nickname: String) -> [String]
}
