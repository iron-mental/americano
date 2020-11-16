//
//  IntroProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation


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

protocol IntroPresenterProtocol: class {
    var view: IntroViewProtocol? { get set }
    var interactor: IntroInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func didClickedRightBarButton(input: String, introState: IntroViewState, beginState: BeginState)
    
    //INTERACTOR -> PRESENTER
    func emailValidInfo(result: Bool)
    func passwordValidInfo(result: Bool)
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
    func getEmailValidInfo(input: String, completionHandler: @escaping (_ : Bool) -> ())
    func getSignUpValidInfo(signUpMaterial: [String]) -> Bool
    func getJoinValidInfo(joinMaterial: [String], completionHandler: @escaping (_ result: Bool, _ message: Any) -> ())
}

protocol IntroLocalDataManagerProtocol: class {
    var email: String { get set }
    var password: String { get set }
    var nickname: String { get set}
    
    func signUp(nickname: String) -> [String]
}
