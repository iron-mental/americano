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
        if result.result {
            if let notiList = result.data {
                self.presenter?.onRetrievedAlert(result: notiList)
            }
        }   
    }
    
    func retrievedAlertFailed(message: String) {
        presenter?.retrievedAlertFailed(message: message)
    }
}
