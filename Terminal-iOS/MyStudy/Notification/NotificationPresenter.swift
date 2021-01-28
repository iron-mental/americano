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
    func didRetrievedAlert(result: [Noti]?) {
        guard let notiList = result else {
            if let view = self.view as? NotificationView {
                view.showToast(controller: view, message: "알림 요청 실패", seconds: 1)
            }
            return
        }
        
        view?.showNotiList(notiList: notiList)
    }
}
