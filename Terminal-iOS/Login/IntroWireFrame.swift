//
//  IntroWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class IntroWireFrame: IntroWireFrameProtocol {
    static func createIntroModule(beginState: BeginState, introState: IntroViewState) -> UIViewController {
        
        let view: IntroViewProtocol = IntroView()
        let presenter: IntroPresenterProtocol = IntroPresenter()
        let interactor: IntroInteractorProtocol = IntroInteractor()
        let remoteDataManager: IntroRemoteDataManagerProtocol = IntroRemoteDataManager()
        let wireFrame: IntroWireFrameProtocol = IntroWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        if let view = view as? IntroView {
            view.beginState = beginState
            view.introState = introState
            return view
        } else {
            return UIViewController()
        }
    }
}
