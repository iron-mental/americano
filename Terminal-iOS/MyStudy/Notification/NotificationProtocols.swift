//
//  NotificationProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol NotificationViewProtocol: class {
    var presenter: NotificationPresenterProtocol? { get set }
    
    func showNotiList(notiList: [Noti])
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol NotificationPresenterProtocol: class {
    var view: NotificationViewProtocol? { get set }
    var interactor: NotificationInteractorInputProtocol? { get set }
    var wireFrame: NotificationWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
}

protocol NotificationInteractorInputProtocol: class {
    var presenter: NotificationInteractorOutputProtocol? { get set }
    var remoteDataManager: NotificationRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveAlert()
}

protocol NotificationInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func onRetrievedAlert(result: [Noti])
    func retrievedAlertFailed(message: String)
}

protocol NotificationWireFrameProtocol: class {
    static func createModule() -> UIViewController
}

protocol NotificationRemoteDataManagerInputProtocol: class {
    var interactor: NotificationRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveAlert()
}

protocol NotificationRemoteDataManagerOutputProtocol: class {
    func onRetrievedAlert(result: BaseResponse<[Noti]>)
    func retrievedAlertFailed(message: String)
}
