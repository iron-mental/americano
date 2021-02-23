//
//  LaunchProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

protocol LaunchViewProtocol: class {
    var presenter: LaunchPresenterProtocol? { get set }
}

protocol LaunchPresenterProtocol: class {
    var view: LaunchViewProtocol? { get set }
    var interactor: LaunchInteractorInputProtocol? { get set }
    var wireFrame: LaunchWireFrameProtocol? { get set }
}

protocol LaunchInteractorInputProtocol: class {
    var presenter: LaunchInteractorOutputProtocol? { get set }
    var remoteDataManager: LaunchRemoteDataManagerInputProtocol? { get set }
}

protocol LaunchInteractorOutputProtocol: class {
    
}

protocol LaunchRemoteDataManagerInputProtocol: class {
    var interactor: LaunchRemoteDataManagerOutputProtocol? { get set }
}

protocol LaunchRemoteDataManagerOutputProtocol: class {
    
}

protocol LaunchWireFrameProtocol: class {
    
}
