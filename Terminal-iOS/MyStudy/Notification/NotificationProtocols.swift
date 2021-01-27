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
    
}

protocol NotificationPresenterProtocol: class {
    var view: NotificationViewProtocol? { get set }
    var interactor: NotificationInteractorInputProtocol? { get set }
    var wireFrame: NotificationWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
}

protocol NotificationInteractorInputProtocol: class {
    var presenter: NotificationPresenterProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol NotificationInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
}

protocol NotificationWireFrameProtocol: class {
    static func createModule() -> UIViewController
}
