//
//  ProfileModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ProfileModifyViewProtocol: class {
    var presenter: ProfileModifyPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
}

protocol ProfileModifyWireFrameProtocol: class {
    static func createProfileModifyModule() -> UIViewController
    
    // PRESENTER -> WIREFRAME
}

protocol ProfileModifyPresenterProtocol: class {
    var view: ProfileModifyViewProtocol? { get set }
    var interactor: ProfileModifyInteractorInputProtocol? { get set }
    var wireFrame: ProfileModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
}

protocol ProfileModifyInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    
}

protocol ProfileModifyInteractorInputProtocol: class {
    var presenter: ProfileModifyInteractorOutputProtocol? { get set }
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    
}

protocol ProfileModifyRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProfileModifyRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol ProfileModifyRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

