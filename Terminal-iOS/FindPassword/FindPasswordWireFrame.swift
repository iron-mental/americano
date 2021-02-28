//
//  FindPasswordWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class FindPasswordWireFrame: FindPasswordWireFrameProtocol {
    static func createFindPasswordModule() -> UIViewController {
        let view: FindPasswordViewProtocol = FindPasswordView()
        let presenter: FindPasswordPresenterProtocol
            & FindPasswordInteractorOutputProtocol = FindPasswordPresenter()
        let interactor: FindPasswordInteractorInputProtocol
            & FindPasswordRemoteDataManagerOutputProtocol = FindPasswordInteractor()
        let wireFrame: FindPasswordWireFrameProtocol = FindPasswordWireFrame()
        let remoteDataManager: FindPasswordRemoteDataManagerInputProtocol = FindPasswordRemoteDataManager()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        
        if let view = view as? UIViewController {
            return view
        } else {
            return UIViewController()
        }
    }
}
