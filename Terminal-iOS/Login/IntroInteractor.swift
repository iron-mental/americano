//
//  IntroInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class IntroInteractor: IntroInteractorProtocol {
    var presenter: IntroPresenterProtocol?
    var remoteDataManager: IntroRemoteDataManagerProtocol?
    
    // MARK: 이메일 유효성 검사
    
    func checkedEmailValid(input: String, beginState: BeginState) {
        if input.contains("@") && input.contains(".") {
            if beginState == .join {
                IntroLocalDataManager.shared.email = input
                self.presenter?.emailValidInfo(result: true)
            } else {
                remoteDataManager?.getEmailValidInfo(input: input) { result in
                    switch result.result {
                    case true:
                        self.presenter?.emailValidInfo(result: true)
                        IntroLocalDataManager.shared.email = input
                    case false:
                        self.presenter?.emailValidInfo(result: false)
                    }
                }
            }
        } else {
            presenter?.emailValidInfo(result: false)
        }
    }
    
    
    // MARK: 로그인 패스워드 체크
    
    func checkedPasswordValid(input: String) {
        if input.count >= 8 && input.count <= 20 {
            presenter?.passwordValidInfo(result: true)
            IntroLocalDataManager.shared.password = input
        } else {
            presenter?.passwordValidInfo(result: false)
        }
    }
    
    
    // MARK: 회원가입 결과 처리
    
    func signUpValid(input: String) {
        if input.count >= 2 && input.count <= 8 {
            IntroLocalDataManager.shared.nickname = input
            remoteDataManager?.getSignUpValidInfo(signUpMaterial: (IntroLocalDataManager.shared.signUp(nickname: input)),
                                                  completionHandler: { result in
            switch result.result {
            case true:
              self.presenter?.signUpValidInfo(result: true)
            case false:
                print("실패이유 :", result.message!)
                }
              }
            )
        } else {
            presenter?.signUpValidInfo(result: false)
        }
    }
    
    // MARK: 로그인 결과 처리

    func checkedJoinValid(input: String) {
        remoteDataManager?.getJoinValidInfo(joinMaterial: [IntroLocalDataManager.shared.email, input],
                                            completionHandler: { result in
        switch result.result {
          case true:
            guard let refreshToken = result.data?.refreshToken else { return }
            guard let accessToken = result.data?.accessToken else { return }
            guard let userID = result.data?.id else { return }
            let refreshResult = KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
            let accessResult = KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
            let idResult = KeychainWrapper.standard.set("\(userID)", forKey: "userID")
            
            print("저장 결과 :", refreshResult && accessResult && idResult)
            if refreshResult && accessResult && idResult {
                self.presenter?.joinValidInfo(result: result.result, joinInfo: String(describing: result.data?.id))
            }
            
          case false:
            self.presenter?.joinValidInfo(result: result.result,
                                          joinInfo: "실패")
            }
          }
        )
      }
    // func checkedJoinValid(input: String) {
    //     remoteDataManager?.getJoinValidInfo(joinMaterial: [IntroLocalDataManager.shared.email,input],
    //                                         completionHandler: { result, data in
            
    //         self.presenter?.joinValidInfo(result: result, joinInfo: "\(data)")
    //     })
    // }
}
