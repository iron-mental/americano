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
    static func createModule() -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentMenuDetailScreen(from view: SetViewProtocol)
}

protocol SetPresenterProtocol: class {
    var view: SetViewProtocol? { get set }
    var interactor: SetInteractortInputProtocol? { get set }
    var wireFrame: SetWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showProfileDetail()
}

protocol SetInteractorOutputProtocol: class {
    func onError()
}

protocol SetInteractortInputProtocol: class {
    var presenter: SetInteractorOutputProtocol? { get set }
    var localDatamanager: SetLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SetRemoteDataManagerInputProtocol? { get set }
}

protocol SetDataManagerInputProtocol: class {
    // INTERACOTER -> DATAMANAGER
}

protocol SetRemoteDataManagerInputProtocol: class {
    
}

protocol SetRemoteDataManagerOutputProtocol: class {
    
}

protocol SetLocalDataManagerInputProtocol: class {

}
