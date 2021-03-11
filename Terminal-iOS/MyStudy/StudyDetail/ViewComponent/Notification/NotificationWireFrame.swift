//
//  NotificationWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class NotificationWireFrame: NotificationWireFrameProtocol {
    static func createModule() -> UIViewController {
        let view: NotificationViewProtocol = NotificationView()
        let presenter: NotificationPresenterProtocol
            & NotificationInteractorOutputProtocol = NotificationPresenter()
        let interactor: NotificationInteractorInputProtocol
            & NotificationRemoteDataManagerOutputProtocol = NotificationInteractor()
        let wireFrame: NotificationWireFrameProtocol = NotificationWireFrame()
        let remoteDataManager: NotificationRemoteDataManagerInputProtocol = NotificationRemoteDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        if let view = view as? UIViewController {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func goToStudyDetail(from view: NotificationViewProtocol, alarmCase: AlarmType, studyTitle: String, studyID: Int) {
        
        let myStudyDetailView = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: studyTitle)
        guard let castedMyStudyDetailView = myStudyDetailView as? MyStudyDetailView else { return }
        guard let notificationListView = view as? UIViewController else { return }
        
        switch alarmCase {
        case .newApply:
            castedMyStudyDetailView.applyState = true
        case .newNotice,
             .updatedNotice:
            castedMyStudyDetailView.viewState = .Notice
        case .studyUpdate,
             .studyHostDelegate,
             .applyAllowed:
            castedMyStudyDetailView.viewState = .StudyDetail
        case .chat, .testPush, .undefined, .studyDelete, .applyRejected: break
        }
        notificationListView.navigationController?.pushViewController(castedMyStudyDetailView, animated: true)
    }
}
