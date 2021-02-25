//
//  NotificationInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
class NotificationInteractor: NotificationInteractorInputProtocol {
    weak var presenter: NotificationInteractorOutputProtocol?
    var remoteDataManager: NotificationRemoteDataManagerInputProtocol?
    
    func retrieveAlert() {
        self.remoteDataManager?.retrieveAlert()
    }
    
    func alarmProcessing(alert: Noti) {
        let alertID = alert.id
        let studyTitle = alert.studyTitle
        let studyID = alert.studyID
        if let alarmCase = AlarmType(rawValue: alert.pushEvent) {
            if !alert.confirm {
                guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
                remoteDataManager?.alertGotConfirmed(userID: Int(userID)!, alertID: alertID)
            }
            presenter?.alarmProcessingResult(alertID: alertID, alarmCase: alarmCase, studyTitle: studyTitle, studyID: studyID)
        } else {
            presenter?.alarmProcessingResult(alertID: alertID, alarmCase: .undefined, studyTitle: studyTitle, studyID: studyID)
        }
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
    func alertConfirmResult(result: BaseResponse<String>) {
        switch result.result {
        case true:
            break
        case false:
            guard let message = result.message else { return }
            presenter?.alertConfirmFailed(message: message)
        }
    }
}
