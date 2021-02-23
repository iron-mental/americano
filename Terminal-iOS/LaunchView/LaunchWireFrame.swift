//
//  LaunchWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class LaunchWireFrame: LaunchWireFrameProtocol {
    
    static func createLaunchModule() -> UIViewController {
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
        
        return view
    }
    func replaceRootViewToIntroView() {
        let home = HomeView()
        guard let window = UIApplication.shared.windows.first else { return }
        window.replaceRootViewController(home, animated: true, completion: nil)
    }
    
    func replaceRootViewToMainView() {
        let main = ViewController()
        guard let window = UIApplication.shared.windows.first else { return }
        window.replaceRootViewController(main, animated: true, completion: nil)
    }
    
    func jumpToAppStore() {
        
    }
}
