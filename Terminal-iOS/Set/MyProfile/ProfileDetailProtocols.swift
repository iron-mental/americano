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
}

protocol ProfileDetailWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
}

protocol ProfileDetailPresenterProtocol: class {
    var view: ProfileDetailViewProtocol? { get set }
    var interactor: ProfileDetailInteractorInputProtocol? { get set }
    var wireFrame: ProfileDetailWireFrameProtocol? { get set }
}

protocol ProfileDetailInteractorInputProtocol: class {
    var presenter: ProfileDetailInteractorOutputProtocol? { get set }
    var localDataManager: ProfileDetailLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: ProfileDetailRemoteDataManagerInputProtocol? { get set }
}

protocol ProfileDetailInteractorOutputProtocol: class {
    
}

protocol ProfileDetailRemoteDataManagerInputProtocol: class {
    
}

protocol ProfileDetailRemoteDataManagerOutputProtocol: class {
    
}

protocol ProfileDetailLocalDataManagerInputProtocol: class {
    
}
