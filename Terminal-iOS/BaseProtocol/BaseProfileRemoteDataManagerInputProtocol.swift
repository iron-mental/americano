//
//  BaseProfileRemoteDataManagerInputProtocol.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

protocol BaseProfileRemoteDataManagerInputProtocol {
    var remoteRequestHandler: BaseProfileRemoteDataManagerOutputProtocol? { get set }
    
    func getUserInfo(userID: Int)
    func getProjectList(userID: Int)
}

protocol BaseProfileRemoteDataManagerOutputProtocol {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
    func onProjectRetrieved(project: BaseResponse<[Project]>)
}
