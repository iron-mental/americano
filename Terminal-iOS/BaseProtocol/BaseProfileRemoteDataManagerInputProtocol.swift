//
//  BaseProfileRemoteDataManagerInputProtocol.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

protocol BaseProfileViewProtocol: class {
    func showUserInfo(userInfo: UserInfo)
    func addProjectToStackView(project: [Project])
    func showLoading()
    func hideLoading()
}

protocol BaseProfileRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: BaseProfileRemoteDataManagerOutputProtocol? { get set }
    
    func getUserInfo(userID: String)
    func getProjectList(userID: String)
}

protocol BaseProfileRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
    func onProjectRetrieved(project: BaseResponse<[Project]>)
}
