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
    func showAlert(message: String)
    func showLoading()
    func hideLoading()
}

protocol NotificationPresenterProtocol: class {
    var view: NotificationViewProtocol? { get set }
    var interactor: NotificationInteractorInputProtocol? { get set }
    var wireFrame: NotificationWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func cellDidTap(alert: Noti)
}

protocol NotificationInteractorInputProtocol: class {
    var presenter: NotificationInteractorOutputProtocol? { get set }
    var remoteDataManager: NotificationRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveAlert()
    func alarmProcessing(alert: Noti)
}

protocol NotificationInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func onRetrievedAlert(result: [Noti])
    func retrievedAlertFailed(message: String)
    func alarmProcessingResult(alertID: Int, alarmCase: AlarmType, studyTitle: String, studyID: Int)
    func alertConfirmFailed(message: String)
    func sessionTaskError(message: String)
}

protocol NotificationWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func goToStudyDetail(from view: NotificationViewProtocol, alarmCase: AlarmType, studyTitle: String, studyID: Int)
}

protocol NotificationRemoteDataManagerInputProtocol: class {
    var interactor: NotificationRemoteDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func retrieveAlert()
    func alertGotConfirmed(userID:Int, alertID: Int)
}

protocol NotificationRemoteDataManagerOutputProtocol: class {
    func onRetrievedAlert(result: BaseResponse<[Noti]>)
    func alertConfirmResult(result: BaseResponse<String>)
    func sessionTaskError(message: String)
}
