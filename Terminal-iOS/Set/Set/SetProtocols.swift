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
}

protocol SetWireFrameProtocol: class {
    static func setCreateModule(id: Int) -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentProfileDetailScreen(from view: SetViewProtocol)
}

protocol SetPresenterProtocol: class {
    var view: SetViewProtocol? { get set }
    var interactor: SetInteractortInputProtocol? { get set }
    var wireFrame: SetWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad(id: Int)
    func showProfileDetail()
    func loggedOut()
}

protocol SetInteractorOutputProtocol: class {
    func didRetrievedUserInfo(userInfo: UserInfo)
    func onError()
}

protocol SetInteractortInputProtocol: class {
    var presenter: SetInteractorOutputProtocol? { get set }
    var localDataManager: SetLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: SetRemoteDataManagerInputProtocol? { get set }
    
    func getUserInfo(id: Int)
}

protocol SetDataManagerInputProtocol: class {
    // INTERACOTER -> DATAMANAGER
    
}

protocol SetRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: SetRemoteDataManagerOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func getUserInfo(id: Int)
}

protocol SetRemoteDataManagerOutputProtocol: class {
    func onUserInfoRetrieved(userInfo: BaseResponse<UserInfo>)
}

protocol SetLocalDataManagerInputProtocol: class {

}
