//
//  ProfileModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ProfileDetailViewProtocol: class {
    var presenter: ProfileDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showUserInfo(with userInfo: UserInfo)
    func addProjectToStackView(with project: [Project])
}

protocol ProfileDetailWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
    func presentProfileModifyScreen(from view: ProfileDetailViewProtocol, userInfo: UserInfo, project: [Project])
    func presentEmailModify(from view: ProfileDetailViewProtocol)
    func presentSNSModify(from view: ProfileDetailViewProtocol)
    func presentProfileModify(from view: ProfileDetailViewProtocol)
    func presentLocationModify(from view: ProfileDetailViewProtocol)
    func presentCareerModify(from view: ProfileDetailViewProtocol)
}

protocol ProfileDetailPresenterProtocol: class {
    var view: ProfileDetailViewProtocol? { get set }
    var interactor: ProfileDetailInteractorInputProtocol? { get set }
    var wireFrame: ProfileDetailWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showProfileModify(userInfo: UserInfo, project: [Project])
    func showEmailModify()
    func showSNSModify()
    func showLocationModify()
    func showCareerModify()
}

protocol ProfileDetailInteractorInputProtocol: class {
    var presenter: ProfileDetailInteractorOutputProtocol? { get set }
    var localDataManager: ProfileDetailLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: ProfileDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getUserInfo()
    func getProjectList()
}

protocol ProfileDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievedUserInfo(userInfo: UserInfo)
    func didRetrievedProject(project: [Project])
}

protocol ProfileDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProfileDetailRemoteDataManagerOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func getUserInfo()
    func getProjectList()
}

protocol ProfileDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
    func onProjectRetrieved(project: BaseResponse<[Project]>)
}

protocol ProfileDetailLocalDataManagerInputProtocol: class {
    
}
