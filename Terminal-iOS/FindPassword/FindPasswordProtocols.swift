//
//  FindPasswordProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol FindPasswordViewProtocol: class {
    var presenter: FindPasswordPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
}

protocol FindPasswordWireFrameProtocol: class {
    static func createModule() -> UIViewController
}

protocol FindPasswordPresenterProtocol: class {
    var view: FindPasswordViewProtocol? { get set }
    var interactor: FindPasswordInteractorInputProtocol? { get set }
    var wireFrame: FindPasswordWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
}

protocol FindPasswordInteractorInputProtocol: class {
    var presenter: FindPasswordInteractorOutputProtocol? { get set }
    var remoteDataManager: FindPasswordRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol FindPasswordInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
}

protocol FindPasswordRemoteDataManagerInputProtocol: class {
    var interactor: FindPasswordRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol FindPasswordRemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
}
