//
//  ProfileModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ProfileModifyViewProtocol: class {
    var presenter: ProfileModifyPresenterProtocol? { get set }
}

protocol ProfileModifyWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
}

protocol ProfileModifyPresenterProtocol: class {
    var view: ProfileModifyViewProtocol? { get set }
    var interactor: ProfileModifyInteractorInputProtocol? { get set }
    var wireFrame: ProfileModifyWireFrameProtocol? { get set }
}

protocol ProfileModifyInteractorInputProtocol: class {
    var presenter: ProfileModifyInteractorOutputProtocol? { get set }
    var localDataManager: ProfileModifyLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol? { get set }
}

protocol ProfileModifyInteractorOutputProtocol: class {
    
}

protocol ProfileModifyRemoteDataManagerInputProtocol: class {
    
}

protocol ProfileModifyRemoteDataManagerOutputProtocol: class {
    
}

protocol ProfileModifyLocalDataManagerInputProtocol: class {
    
}
