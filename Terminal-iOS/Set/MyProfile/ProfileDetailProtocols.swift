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
    
}

protocol ProfileDetailWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
}

protocol ProfileDetailPresenterProtocol: class {
    var view: ProfileDetailViewProtocol? { get set }
    var interactor: ProfileDetailInteractorInputProtocol? { get set }
    var wireFrame: ProfileDetailWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad(id: Int)
}

protocol ProfileDetailInteractorInputProtocol: class {
    var presenter: ProfileDetailInteractorOutputProtocol? { get set }
    var localDataManager: ProfileDetailLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: ProfileDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getUserInfo()
}

protocol ProfileDetailInteractorOutputProtocol: class {
    
}

protocol ProfileDetailRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    func getUserInfo(id: Int)
}

protocol ProfileDetailRemoteDataManagerOutputProtocol: class {
    
}

protocol ProfileDetailLocalDataManagerInputProtocol: class {
    
}
