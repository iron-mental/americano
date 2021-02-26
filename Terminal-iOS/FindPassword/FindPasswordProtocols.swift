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
    func showResult(result: Bool, message: String?)
}

protocol FindPasswordWireFrameProtocol: class {
    static func createFindPasswordModule() -> UIViewController
}

protocol FindPasswordPresenterProtocol: class {
    var view: FindPasswordViewProtocol? { get set }
    var interactor: FindPasswordInteractorInputProtocol? { get set }
    var wireFrame: FindPasswordWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func resetRequest(email: String)
}

protocol FindPasswordInteractorInputProtocol: class {
    var presenter: FindPasswordInteractorOutputProtocol? { get set }
    var remoteDataManager: FindPasswordRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func resetRequest(email: String)
}

protocol FindPasswordInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func resetResponse(result: Bool, message: String)
}

protocol FindPasswordRemoteDataManagerInputProtocol: class {
    var interactor: FindPasswordRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func resetPassword(email: String)
}

protocol FindPasswordRemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func resetResponse(result: BaseResponse<Bool>)
}
