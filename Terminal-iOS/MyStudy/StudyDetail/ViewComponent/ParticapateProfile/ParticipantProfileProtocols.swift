//
//  ParticapateProfileProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/24.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol ParticapateProfileViewProtocol: BaseProfileViewProtocol {
    var presenter: ParticapateProfilePresenterInputProtocol? { get set }
    
    //PRESENTER -> View
    func showError(message: String)
}

protocol ParticapateProfilePresenterInputProtocol: class {
    var view: ParticapateProfileViewProtocol? { get set }
    var interactor: ParticapateProfileInteractorInputProtocol? { get set }
    var wireFrame: ParticapateProfileWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ParticapateProfileInteractorInputProtocol: class {
    var presenter: ParticapateProfileInteractorOutputProtocol? { get set }
    var remoteDataManager: ParticapateProfileRemoteDataManagerInputProtocol? { get set }
    var userID: Int? { get set }
    
    //PRESENTER -> INTERACTOR
    func getUserInfo()
}

protocol ParticapateProfileInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func retriveUserInfo(result: Bool, userInfo: UserInfo)
    func retriveProjectList(result: Bool, projectList: [Project])
}

protocol ParticapateProfileRemoteDataManagerInputProtocol: BaseProfileRemoteDataManagerInputProtocol {
    //INTERACTOR -> REMOTEDATAMANAGER
}

protocol ParticapateProfileRemoteDataManagerOutputProtocol: BaseProfileRemoteDataManagerOutputProtocol {
    //REMOTEDATAMANAGER -> INTERACTOR
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
    func onProjectRetrieved(project: BaseResponse<[Project]>)
}

protocol ParticapateProfileWireFrameProtocol: class {
    static func createApplyUserDetailModule(userInfo: ApplyUser) -> UIViewController
}
