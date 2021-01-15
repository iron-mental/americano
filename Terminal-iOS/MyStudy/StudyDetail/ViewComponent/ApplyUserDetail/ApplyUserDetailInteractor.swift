//
//  ApplyUserDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ApplyUserDetailInteractor: ApplyUserDetailInteractorInputProtocol {
    var presenter: ApplyUserDetailInteractorOutputProtocol?
    var remoteDataManager: ApplyUserDetailRemoteDataManagerInputProtocol?
    
    func getUserInfo(userID: Int) {
//        <#code#>
    }
    
    
}

extension ApplyUserDetailInteractor: ApplyUserDetailRemoteDataManagerOutputProtocol {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>) {
//        <#code#>
    }
    
    func onProjectRetrieved(project: BaseResponse<[Project]>) {
//        <#code#>
    }
}
