//
//  NotificationWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class NotificationWireFrame: NotificationWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view: NotificationViewProtocol = NotificationView()
        let presenter: NotificationPresenterProtocol & NotificationInteractorOutputProtocol = NotificationPresenter()
        let interactor: NotificationInteractorInputProtocol = NotificationInteractor()
        let wireFrame: NotificationWireFrameProtocol = NotificationWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        
        if let view = view as? UIViewController {
            return view
        } else {
            return UIViewController()
        }
    }
}
