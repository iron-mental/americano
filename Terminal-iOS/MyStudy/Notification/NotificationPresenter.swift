//
//  NotificationPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class NotificationPresenter: NotificationPresenterProtocol {
    var view: NotificationViewProtocol?
    var interactor: NotificationInteractorInputProtocol?
    var wireFrame: NotificationWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.retrieveAlert()
    }
}

extension NotificationPresenter: NotificationInteractorOutputProtocol {
    func onRetrievedAlert(result: [Noti]) {
        view?.showNotiList(notiList: result)
    }
}
