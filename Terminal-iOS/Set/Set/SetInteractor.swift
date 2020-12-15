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
}

extension SetInteractor: SetRemoteDataManagerOutputProtocol {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>) {
        guard let result = userInfo.data else { return }
        //기존의 내용을 수정
        CoreDataManager.shared.putUserInfo(userInfo: result)
        
        if let coreUserInfo = CoreDataManager.shared.getUserinfo() {
            presenter?.didRetrievedUserInfo(userInfo: coreUserInfo)
        }
    }
    func error() {
        
    }
}
