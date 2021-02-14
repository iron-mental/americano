//
//  NotificationInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class NotificationInteractor: NotificationInteractorInputProtocol {
    var presenter: NotificationInteractorOutputProtocol?
    var remoteDataManager: NotificationRemoteDataManagerInputProtocol?
    
    func retrieveAlert() {
        self.remoteDataManager?.retrieveAlert()
    }
}

extension NotificationInteractor: NotificationRemoteDataManagerOutputProtocol {
    func onRetrievedAlert(result: BaseResponse<[Noti]>) {
        switch result.result {
        case true:
            guard let notiList = result.data else { return }
            self.presenter?.onRetrievedAlert(result: notiList)
        case false:
            guard let message = result.message else { return }
            presenter?.retrievedAlertFailed(message: message)
        }
    }
}
