//
//  LocationModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol LocationModifyViewProtocol: class {
    var presenter: LocationModifyPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showAddress(address: [Address])
}

protocol LocationModifyWireFrameProtocol: class {
    static func createModule() -> UIViewController
}

protocol LocationModifyPresenterProtocol: class {
    var view: LocationModifyViewProtocol? { get set }
    var interactor: LocationModifyInteractorInputProtocol? { get set }
    var wireFrame: LocationModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func completeModify(location: String)
}

protocol LocationModifyInteractorInputProtocol: class {
    var presenter: LocationModifyInteractorOutputProtocol? { get set }
    var remoteDataManager: LocationModifyRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveAddress()
}

protocol LocationModifyInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func retrievedAddress(result: Bool, address: [Address])
}

protocol LocationModifyRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: LocationModifyRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveAddress()
    
}

protocol LocationModifyRemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func onRetrieveAddress(result: BaseResponse<[Address]>)
}
