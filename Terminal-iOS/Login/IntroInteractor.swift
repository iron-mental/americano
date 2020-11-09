//
//  IntroInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class IntroInteractor: IntroInteractorProtocol {
    var presenter: IntroPresenterProtocol?
    var remoteDataManager: IntroRemoteDataManagerProtocol?
    
    func checkedEmailValid(input: String) {
        if input.contains("@") && input.contains(".") {
            remoteDataManager?.getEmailValidInfo(input: input, completionHandler: { result in
                if result {
                    self.presenter?.emailValidInfo(result: true)
                    IntroLocalDataManager.shared.email = input
                } else {
                    self.presenter?.emailValidInfo(result: false)
                }
            }
            )} else {
                presenter?.emailValidInfo(result: false)
            }
    }
    
    func checkedPasswordValid(input: String) {
        if input.count >= 8 && input.count <= 20 {
            presenter?.passwordValidInfo(result: true)
            IntroLocalDataManager.shared.password = input
        } else {
            presenter?.passwordValidInfo(result: false)
        }
    }
    
    func signUpValid(input: String) {
        if input.count >= 2 && input.count <= 8 {
            IntroLocalDataManager.shared.nickname = input
            
            if ((remoteDataManager?.getSignUpValidInfo(signUpMaterial: (IntroLocalDataManager.shared.signUp(nickname: input)))) != nil) {
                presenter?.signUpValidInfo(result: true)
            }
        } else {
            presenter?.signUpValidInfo(result: false)
        }
    }
}
