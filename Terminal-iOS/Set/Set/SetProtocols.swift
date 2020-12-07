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
}

protocol SetInteractorOutputProtocol: class {
    func onError()
}

protocol SetInteractortInputProtocol: class {
    var presenter: SetInteractorOutputProtocol? { get set }
    var localDatamanager: SetLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SetRemoteDataManagerInputProtocol? { get set }
    
    func getUserInfo(id: Int)
}

protocol SetDataManagerInputProtocol: class {
    // INTERACOTER -> DATAMANAGER
    
}

protocol SetRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProfileDetailRemoteDataManagerOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func getUserInfo(id: Int)
}

protocol SetRemoteDataManagerOutputProtocol: class {
    
}

protocol SetLocalDataManagerInputProtocol: class {

}
