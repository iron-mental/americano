//
//  SetInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SetInteractor: SetInteractortInputProtocol {
    var presenter: SetInteractorOutputProtocol?
    var localDataManager: SetLocalDataManagerInputProtocol?
    var remoteDataManager: SetRemoteDataManagerInputProtocol?
    
    
    func getUserInfo() {
        remoteDataManager?.getUserInfo()
    }
    
    func emailAuthRequest() {
        remoteDataManager?.emailAuthRequest()
    }
}

extension SetInteractor: SetRemoteDataManagerOutputProtocol {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>) {
        guard let result = userInfo.data else { return }
        //기존의 내용을 수정
        if let _ = CoreDataManager.shared.getUserinfo() {
            //core에 있다는소리
            //put 하는 함수
            CoreDataManager.shared.putUserInfo(userInfo: result)
        } else {
            //core가 nil 이라는 소리
            //create 하는 함수
            CoreDataManager.shared.createUserInfo(userInfo: result)
        }
        presenter?.didRetrievedUserInfo(userInfo: result)
    }
    
    func emailAuthResponse(result: BaseResponse<Bool>) {
        let isSuccess = result.result
        let message = result.message!
        presenter?.eamilAuthResponse(result: isSuccess, message: message)
    }
    
    func error() {
        if let coreUserInfo = CoreDataManager.shared.getUserinfo() {
            presenter?.didRetrievedUserInfo(userInfo: coreUserInfo)
        }
    }
}
