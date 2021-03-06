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
    weak var presenter: IntroPresenterProtocol?
    var remoteDataManager: IntroRemoteDataManagerProtocol?
    
    // MARK: 이메일 유효성 검사
    
    func checkedEmailValid(input: String, beginState: BeginState) {
        if input.contains("@") && input.contains(".") {
            remoteDataManager?.getEmailValidInfo(input: input, completionHandler: { result in
                switch result.result {
                case true:
                    guard let duplicate = result.data?.duplicate else { return }
                    switch beginState {
                    case .join:
                        //로그인
                        switch duplicate {
                        case true:
                            //등록된 이메일
                            self.presenter?.emailValidInfo(result: true, message: "")
                            IntroLocalDataManager.shared.email = input
                        case false:
                            //등록되어있지 않은 이메일
                            self.presenter?.emailValidInfo(result: false, message: "존재하지 않는 이메일입니다.")
                        }
                    case .signUp:
                        //회원가입
                        switch duplicate {
                        case true:
                            //등록된 이메일
                            self.presenter?.emailValidInfo(result: false, message: "중복된 이메일입니다.")
                        case false:
                            //등록되어있지 않은 이메일
                            self.presenter?.emailValidInfo(result: true, message: result.message ?? "")
                        }
                        IntroLocalDataManager.shared.email = input
                    }
                case false:
                    switch beginState {
                    case .join:
                        self.presenter?.emailValidInfo(result: false, message: result.message ?? "")
                    case .signUp:
                        self.presenter?.emailValidInfo(result: false, message: result.message ?? "")
                    }
                }
            })
        } else {
            presenter?.emailValidInfo(result: false, message: "이메일 형식이 맞지 않습니다.")
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
                                                        guard let message = result.message else { return }
                                                        self.presenter?.nicknameValidInfo(result: false, message: message)
                                                    }
                                                  }
            )
        } else {
            self.presenter?.nicknameValidInfo(result: false, message: "닉네임은 2 ~ 8 글자 여야 합니다.")
        }
    }
    
    // MARK: 로그인 결과 처리
    
    func checkedJoinValid(input: String) {
        
        remoteDataManager?.getJoinValidInfo(joinMaterial: [IntroLocalDataManager.shared.email, input],
                                            completionHandler: { result in
                                                switch result.result {
                                                case true:
                                                    if let refreshToken = result.data?.refreshToken,
                                                       let accessToken = result.data?.accessToken,
                                                       let userID = result.data?.id {
                                                        let refreshResult = KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
                                                        let accessResult = KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
                                                        let idResult = KeychainWrapper.standard.set("\(userID)", forKey: "userID")
                                                        print("저장 결과 :", refreshResult && accessResult && idResult)
                                                        if refreshResult && accessResult && idResult {
                                                            self.presenter?.joinValidInfo(result: result.result, message: String(describing: result.data?.id))
                                                        }
                                                    }
                                                case false:
                                                    self.presenter?.joinValidInfo(result: result.result,
                                                                                  message: result.message ?? "로그인 실패")
                                                }
                                            }
        )
    }
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
