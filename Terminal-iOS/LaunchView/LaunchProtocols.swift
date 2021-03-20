//
//  LaunchProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol LaunchViewProtocol: class {
    var presenter: LaunchPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func showVersionUpdateAlert(alertType: AlertType)
    func showError(message: String)
    func showMainTenanceAlert()
}

protocol LaunchPresenterProtocol: class {
    var view: LaunchViewProtocol? { get set }
    var interactor: LaunchInteractorInputProtocol? { get set }
    var wireFrame: LaunchWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func getRefreshTokenValid()
    func jumpToAppStore()
}

protocol LaunchInteractorInputProtocol: class {
    var presenter: LaunchInteractorOutputProtocol? { get set }
    var remoteDataManager: LaunchRemoteDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getVersionCheck()
    func refreshTokenCheck()
}

protocol LaunchInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func versionNeedUpdate(force: VersionResultType)
    func refreshTokenIsEmpty()
    func refreshTokenResult(result: Bool)
    func serverMaintenance()
    func sessionTaskError(message: String)
}

protocol LaunchRemoteDataManagerInputProtocol: class {
    var interactor: LaunchRemoteDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func getVersionCheck(version: String)
    func getRefreshTokenValid(userID: String)
}

protocol LaunchRemoteDataManagerOutputProtocol: class {
    //REMOTEDATAMANAGER -> INTERACTOR
    func getVersionResult(result: BaseResponse<VersionResult>)
    func getRefreshTokenResult(result: BaseResponse<UserInfo>)
    func sessionTaskError(message: String)
}

protocol LaunchWireFrameProtocol: class {
    var studyID: Int? { get set }
    var pushEvent: AlarmType? { get set }
    static func createLaunchModule(studyID: Int?, pushEvent: AlarmType?) -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func replaceRootViewToIntroView()
    func replaceRootViewToMainView()
    func jumpToAppStore()
}
