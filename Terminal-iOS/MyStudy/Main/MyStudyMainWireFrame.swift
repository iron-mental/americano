//
//  MyStudyMainWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainWireFrame: MyStudyMainWireFrameProtocol {
    
    static func createMyStudyMainViewModul() -> UIViewController {
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
    
    func goToStudyDetailView(view: UIViewController, selectedStudy: MyStudy) {
        let myStudyDetailView =  MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: selectedStudy.id)
        view.navigationController?.pushViewController(myStudyDetailView, animated: true)
    }
}
