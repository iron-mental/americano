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
    
    func cellDidTap(alert: Noti) {
        interactor?.alarmProcessing(alert: alert)
    }
}

extension NotificationPresenter: NotificationInteractorOutputProtocol {
    func onRetrievedAlert(result: [Noti]) {
        view?.showNotiList(notiList: result)
    }
    
    func retrievedAlertFailed(message: String) {
        view?.showError(message: message)
    }
    
    func alarmProcessingResult(alertID: Int, alarmCase: AlarmCase, studyTitle: String) {
        switch alarmCase {
        case .chat,
             .studyUpdate,
             .studyHostDelegate,
             .newApply,
             .applyAllowed,
             .newNotice,
             .updatedNotice:
            wireFrame?.goToStudyDetail(alertID: alertID, alarmCase: alarmCase, studyTitle: studyTitle)
        case .studyDelete:
            view?.showAlert(message: "\(studyTitle) 스터디가 삭제되었습니다.")
        case .applyRejected:
            view?.showAlert(message: "\(studyTitle) 스터디 입장이 거절되었습니다")
        case .undefined:
            view?.showError(message: "서버와의 연결이 불안정 합니다.")
        case .testPush: break
//            <#code#>
        }
    }
}
