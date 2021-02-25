//
//  MyStudyMainWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainWireFrame: MyStudyMainWireFrameProtocol {
    var studyID: Int?
    var pushEvent: AlarmType?
    
    static func createMyStudyMainViewModul(studyID: Int? = nil, alarmType: AlarmType? = nil) -> UIViewController {
        let view: MyStudyMainViewProtocol = MyStudyMainView()
        let presenter: MyStudyMainPresenterProtocol = MyStudyMainPresenter()
        let interactor: MyStudyMainInteractorProtocol = MyStudyMainInteractor()
        let remoteDataManager: MyStudyMainRemoteDataManagerProtocol = MyStudyMainRemoteDataManager()
        let localDataManager: MyStudyMainLocalDataManagerProtocol = MyStudyMainLocalDataManager()
        let wireFrame: MyStudyMainWireFrameProtocol = MyStudyMainWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteManager = remoteDataManager
        interactor.localManager = localDataManager
        
        if let id = studyID, let event = alarmType {
            view.startedByPushNotification = true
            wireFrame.studyID = id
            wireFrame.pushEvent = event
        }
        if let view = view as? MyStudyMainView {
            return view
        } else {
            return UIViewController()
        }
        
    }
    
    func goToApplyList(from view: MyStudyMainViewProtocol) {
        let myApplyListViewController = MyApplyListWireFrame.createStudyListModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(myApplyListViewController, animated: true)
        }
    }
    
    func goToAlert(from view: MyStudyMainViewProtocol) {
        let notificationView = NotificationWireFrame.createModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(notificationView, animated: true)
        }
    }
    
    func goToStudyDetailView(view: UIViewController, studyID: Int, studyTitle: String) {
        let myStudyDetailView =  MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: studyID, studyTitle: studyTitle)
        view.navigationController?.pushViewController(myStudyDetailView, animated: true)
    }
    
    func goToStudyDetailDirectly(view: UIViewController) {
        if let id = self.studyID, let event = self.pushEvent {
            
            let myStudyDetailView = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: id, studyTitle: "")
            
            if let castedMyStudyDetailView = myStudyDetailView as? MyStudyDetailView {
                switch event {
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
                
                view.navigationController?.pushViewController(castedMyStudyDetailView, animated: true)
            }
        }
    }
}
