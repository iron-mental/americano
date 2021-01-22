//
//  SetViewProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SetViewProtocol: class {
    var presenter: SetPresenterProtocol? { get set }
    
    func loggedOut()
    func showUserInfo(with userInfo: UserInfo)
    func emailAuthResponse(result: Bool, message: String)
    
    func showLoading()
    func hideLoading()
}

protocol SetWireFrameProtocol: class {
    static func setCreateModule() -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentProfileDetailScreen(from view: SetViewProtocol)
    func presentUserWithdrawal(from view: SetViewProtocol)
}

protocol SetPresenterProtocol: class {
    var view: SetViewProtocol? { get set }
    var interactor: SetInteractortInputProtocol? { get set }
    var wireFrame: SetWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showProfileDetail()
    func emailAuthRequest()
    
    func loggedOut()
    func userWithdrawal()
    
}

protocol SetInteractorOutputProtocol: class {
    func didRetrievedUserInfo(userInfo: UserInfo)
    func eamilAuthResponse(result: Bool, message: String)
    func onError()
}

protocol SetInteractortInputProtocol: class {
    var presenter: SetInteractorOutputProtocol? { get set }
    var localDataManager: SetLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: SetRemoteDataManagerInputProtocol? { get set }
    
    func getUserInfo()
    func emailAuthRequest()
}

protocol SetDataManagerInputProtocol: class {
    // INTERACOTER -> DATAMANAGER
    
}

protocol SetRemoteDataManagerInputProtocol: class {
    var interactor: SetRemoteDataManagerOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func getUserInfo()
    func emailAuthRequest()
}

protocol SetRemoteDataManagerOutputProtocol: class {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
    func emailAuthResponse(result: BaseResponse<Bool>)
    func error()
}

protocol SetLocalDataManagerInputProtocol: class {

}
