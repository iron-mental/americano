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
    
    // PRESENTER -> INTERACTOR
    func retrieveAlert()
}

protocol NotificationInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didRetrievedAlert(result: [Noti]?)
}

protocol NotificationWireFrameProtocol: class {
    static func createModule() -> UIViewController
}
