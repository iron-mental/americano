//
//  ApplyUserDetailProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol ApplyUserDetailViewProtocol {
    var presenter: ApplyUserDetailPresenterInputProtocol? { get set }
    
    //PRESENTER -> View
    func showUserInfo(userInfo: UserInfo)
    func showProjectList(projectList: [Project])
    func showError()
}

protocol ApplyUserDetailPresenterInputProtocol {
    var view: ApplyUserDetailViewProtocol? { get set }
    var wireFrame: ApplyUserDetailWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(userID: Int)
}

protocol ApplyUserDetailInteractorInputProtocol {
    var presenter: ApplyUserDetailInteractorOutputProtocol? { get set }
    var remoteDataManager: ApplyUserDetailRemoteDataManagerInputProtocol { get set }
    
    //PRESENTER -> INTERACTOR
    func getUserInfo(userID: Int)
}

protocol ApplyUserDetailInteractorOutputProtocol {
    //INTERACTOR -> PRESENTER
    func retriveUserInfo(result: Bool, userInfo: UserInfo)
    func retriveProjectList(result: Bool, projectList: [Project])
}

protocol ApplyUserDetailRemoteDataManagerInputProtocol: BaseProfileRemoteDataManagerInputProtocol {
    //INTERACTOR -> REMOTEDATAMANAGER
}

protocol ApplyUserDetailRemoteDataManagerOutputProtocol: BaseProfileRemoteDataManagerOutputProtocol {
    //REMOTEDATAMANAGER -> INTERACTOR
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
    func onProjectRetrieved(project: BaseResponse<[Project]>)
}

protocol ApplyUserDetailWireFrameProtocol {
    static func createApplyUserDetailModule(userID: Int) -> UIViewController
}
