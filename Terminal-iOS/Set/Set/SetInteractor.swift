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
        CoreDataManager.shared.getUserinfo()
        remoteDataManager?.getUserInfo()
    }
}

extension SetInteractor: SetRemoteDataManagerOutputProtocol {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>) {
        guard let result = userInfo.data else { return }
        CoreDataManager.shared.putUserInfo(userInfo: result)
        presenter?.didRetrievedUserInfo(userInfo: result)
    }
    func error() {
        
//        presenter?.didRetrievedUserInfo(userInfo: CoreDataManager.shared.getUserinfo())
    }
}
