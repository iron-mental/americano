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
    func showInvalidNickNameAction()
}

protocol IntroPresenterProtocol: class {
    var view: IntroViewProtocol? { get set }
    var interactor: IntroInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func didClickedRightBarButton()
    
    //INTERACTOR -> PRESENTER
    func emailValidInfo(result: Bool)
    func signUpValidInfo(result: Bool)
}

protocol IntroInteractorProtocol: class {
    var presenter: IntroPresenterProtocol? { get set }
    var remoteDataManager: IntroRemoteDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func checkedEmailValid()
    func signUpValid()
}

protocol IntroRemoteDataManagerProtocol: class {
    func getEmailValidInfo()
    func getSignUpValidInfo()
}
