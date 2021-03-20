//
//  ProfileModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ProfileDetailViewProtocol: BaseProfileViewProtocol {
    var presenter: ProfileDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showError(message: String)
}

protocol ProfileDetailWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
    func presentEmailModify(from view: ProfileDetailViewProtocol,
                            email: String)
    func presentSNSModify(from view: ProfileDetailViewProtocol,
                          github: String,
                          linkedin: String,
                          web: String)
    func presentProfileModify(from view: ProfileDetailViewProtocol, profile: Profile)
    func presentLocationModify(from view: ProfileDetailViewProtocol)
    func presentCareerModify(from view: ProfileDetailViewProtocol,
                             title: String,
                             Contents: String)
    func presentProjectModify(from view: ProfileDetailViewProtocol, project: [Project])
}

protocol ProfileDetailPresenterProtocol: class {
    var view: ProfileDetailViewProtocol? { get set }
    var interactor: ProfileDetailInteractorInputProtocol? { get set }
    var wireFrame: ProfileDetailWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showProfileModify(profile: Profile)
    func showEmailModify(email: String)
    func showSNSModify(github: String, linkedin: String, web: String)
    func showLocationModify()
    func showCareerModify(title: String, contents: String)
    func showProjectModify(project: [Project])
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
    func sessionTaskError(message: String)
}

protocol ProfileDetailRemoteDataManagerInputProtocol: BaseProfileRemoteDataManagerInputProtocol {

    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol ProfileDetailRemoteDataManagerOutputProtocol: BaseProfileRemoteDataManagerOutputProtocol {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
    func onProjectRetrieved(project: BaseResponse<[Project]>)
    func sessionTaskError(message: String)
}

protocol ProfileDetailLocalDataManagerInputProtocol: class {
    
}
