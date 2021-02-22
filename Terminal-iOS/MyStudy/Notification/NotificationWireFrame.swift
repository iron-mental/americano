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
    
    func goToStudyDetail(from view: NotificationViewProtocol, alarmCase: AlarmCase, studyTitle: String, studyID: Int) {
        switch alarmCase {
        case .newApply:
            let myStudyDetailView = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: studyTitle)
            if let castedMyStudyDetailView = myStudyDetailView as? MyStudyDetailView {
                castedMyStudyDetailView.applyState = true
                if let notificationListView = view as? UIViewController {
                    notificationListView.navigationController?.pushViewController(castedMyStudyDetailView, animated: true)
                }
            }
        case .newNotice,
             .updatedNotice:
            let myStudyDetailView = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: studyTitle)
            if let castedMyStudyDetailView = myStudyDetailView as? MyStudyDetailView {
                castedMyStudyDetailView.viewState = .Notice
                if let notificationListView = view as? UIViewController {
                    notificationListView.navigationController?.pushViewController(castedMyStudyDetailView, animated: true)
                }
            }
        case .studyUpdate,
             .studyHostDelegate,
             .applyAllowed:
            let myStudyDetailView = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: studyTitle)
            if let castedMyStudyDetailView = myStudyDetailView as? MyStudyDetailView {
                castedMyStudyDetailView.viewState = .StudyDetail
                if let notificationListView = view as? UIViewController {
                    notificationListView.navigationController?.pushViewController(castedMyStudyDetailView, animated: true)
                }
            }
        case .chat:
            break
        case .testPush:
            break
        case .undefined,
             .studyDelete,
             .applyRejected:
            print("이 곳에 오지 않습니다.")
        }
    }
}
