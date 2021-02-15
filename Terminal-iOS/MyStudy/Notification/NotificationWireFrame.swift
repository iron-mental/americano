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
    
    func goToStudyDetail(from view: NotificationViewProtocol, alertID: Int, alarmCase: AlarmCase, studyTitle: String, studyID: Int) {
        switch alarmCase {
        case .newApply: break
//            스터디 메인 (alert넣어서) -> 신청자 목록 까지 들어가줘야 알림 처리도 하면서 목록까지 뷰잉
        case .chat,
             .studyUpdate,
             .studyHostDelegate,
             .applyAllowed,
             .newNotice,
             .updatedNotice:
            let myStudyDetailView = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: studyTitle, alertID: alertID)
            if let notificationListView = view as? UIViewController {
                notificationListView.navigationController?.pushViewController(myStudyDetailView, animated: true)
            }
        case .testPush:
            break
        case .undefined,
             .studyDelete,
             .applyRejected:
            print("이 곳에 오지 않습니다.")
        }
        
    }
}
