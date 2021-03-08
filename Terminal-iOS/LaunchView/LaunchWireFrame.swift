//
//  LaunchWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class LaunchWireFrame: LaunchWireFrameProtocol {
    var studyID: Int?
    var pushEvent: AlarmType?
    
    static func createLaunchModule(studyID: Int? = nil, pushEvent: AlarmType? = nil) -> UIViewController {
        let view = LaunchView()
        let presenter: LaunchPresenterProtocol & LaunchInteractorOutputProtocol = LaunchPresenter()
        let interactor: LaunchInteractorInputProtocol & LaunchRemoteDataManagerOutputProtocol = LaunchInteractor()
        let remoteDataManager: LaunchRemoteDataManagerInputProtocol = LaunchRemoteDataManager()
        let wireFrame: LaunchWireFrameProtocol = LaunchWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        
        wireFrame.studyID = studyID
        wireFrame.pushEvent = pushEvent
        
        return view
    }
    
    func replaceRootViewToIntroView() {
        let home = HomeView()
        let nav = UINavigationController(rootViewController: home)
        guard let window = UIApplication.shared.windows.first else { return }
        window.replaceRootViewController(nav, animated: true, completion: nil)
    }
    
    func replaceRootViewToMainView() {
        guard let window = UIApplication.shared.windows.first else { return }
        let main = ViewController()
        if let id = studyID, let event = pushEvent {
            main.targetStudyID = id
            main.targetAlarmType = event
            main.attribute()
        }
        window.replaceRootViewController(main, animated: true, completion: nil)
    }

    func jumpToAppStore() {
        if let url = URL(string: "https://apps.apple.com/us/app/id1557178596"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url) }
        }
    }
}
