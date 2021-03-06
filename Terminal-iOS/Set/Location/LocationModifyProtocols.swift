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
    func modifyResultHandle(result: Bool, message: String)
    func showError(message: String)
    func showLoading()
    func hideLoading()
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
    func completeModify(sido: String, sigungu: String)
}

protocol LocationModifyInteractorInputProtocol: class {
    var presenter: LocationModifyInteractorOutputProtocol? { get set }
    var remoteDataManager: LocationModifyRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveAddress()
    func retrieveCoordinates(sido: String, sigungu: String)
}

protocol LocationModifyInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func retrievedAddress(result: Bool, address: [Address])
    func didCompleteModify(result: Bool, message: String)
    func retrievedAddressFailed(message: String)
    func sessionTaskError(message: String)
}

protocol LocationModifyRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: LocationModifyRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveAddress()
    func retrieveCoordinates(location: String, completion: @escaping (_ x: Double, _ y: Double) -> Void)
    func completeModify(params: [String: Any])
}

protocol LocationModifyRemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func onRetrieveAddress(result: BaseResponse<[Address]>)
    func didCompleteModify(result: BaseResponse<Bool>)
    func sessionTaskError(message: String)
}
