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
        
        remoteDataManager?.getUserInfo(userID: userID)
        remoteDataManager?.getProjectList(userID: userID)
    }
    
}

extension ApplyUserDetailInteractor: ApplyUserDetailRemoteDataManagerOutputProtocol {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>) {
        
        switch userInfo.result {
        case true:
            if let data = userInfo.data {
                presenter?.retriveUserInfo(result: userInfo.result, userInfo: data)
            }
            break
        case false:
            print("ApplyUserDetailInterator 에서 생긴 에러")
            break
        }
    }
    
    func onProjectRetrieved(project: BaseResponse<[Project]>) {
        
        switch project.result {
        case true:
            if let data = project.data {
                presenter?.retriveProjectList(result: project.result, projectList: data)
            }
            break
        case false:
            print("ApplyUserDetailInterator 에서 생긴 에러")
            break
        }
    }
}
